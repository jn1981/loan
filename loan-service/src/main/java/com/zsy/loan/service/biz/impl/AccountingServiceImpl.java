package com.zsy.loan.service.biz.impl;

import com.zsy.loan.bean.convey.AccountingDetailVo;
import com.zsy.loan.bean.convey.AccountingMainVo;
import com.zsy.loan.bean.entity.biz.TBizAcct;
import com.zsy.loan.bean.entity.biz.TBizAcctRecord;
import com.zsy.loan.bean.enumeration.BizExceptionEnum;
import com.zsy.loan.bean.enumeration.BizTypeEnum.ProcessStatusEnum;
import com.zsy.loan.bean.exception.LoanException;
import com.zsy.loan.dao.biz.AcctRecordRepo;
import com.zsy.loan.dao.biz.AcctRepo;
import com.zsy.loan.service.sequence.IdentifyGenerated;
import com.zsy.loan.utils.BigDecimalUtil;
import com.zsy.loan.utils.CollectorsUtils;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 账务处理
 *
 * @Author zhangxh
 * @Date 2019-01-18  12:27
 */
@Service
public class AccountingServiceImpl {

  @Autowired
  private AcctRepo repository;

  @Autowired
  private AcctRecordRepo recordRepo;

  /**
   * 统一记账接口
   */
  @Transactional
  public Boolean accounting(AccountingMainVo vo) {

    List<AccountingDetailVo> detailVoList = vo.getDetail();

    /**
     * 补齐账户信息,并翻译成交易流水
     */
    List<TBizAcctRecord> recordList = new ArrayList<>(detailVoList.size());
    long groupNo = IdentifyGenerated.INSTANCE.getNextId(); //组号
    for (AccountingDetailVo detailVo : detailVoList) {

      //补齐账户
      if (detailVo.getAcctNo() == null) {

        if (detailVo.getCustNo() != null) {
          TBizAcct acct = repository.findByCustNo(detailVo.getCustNo()).get();
          detailVo.setAcctNo(acct.getId());
        }

        if (detailVo.getAcctType() != null) {
          TBizAcct acct = repository.findByAcctType(detailVo.getAcctType()).get();
          detailVo.setAcctNo(acct.getId());
        }
      }

      //翻译成交易流水
      TBizAcctRecord record = TBizAcctRecord.builder()
          .id(null)
          .groupNo(groupNo)
          .orgNo(vo.getOrgNo())
          .acctNo(detailVo.getAcctNo())
          .type(vo.getType())
          .amtType(detailVo.getAmtType())
          .acctDate(vo.getAcctDate())
          .amt(detailVo.getAmt())
          .balDir(detailVo.getBalDir())
          .status(ProcessStatusEnum.SUCCESS.getValue())
          .remark("记账成功")
          .build();

      recordList.add(record);
    }

    /**
     * 汇总计算要更新的账户信息
     */
    TreeMap<Long, BigDecimal> upAcctMap = detailVoList.stream().collect(
        Collectors.groupingBy(AccountingDetailVo::getAcctNo, TreeMap::new, CollectorsUtils.summingBigDecimal(AccountingDetailVo::getAmtByBalDir)));

    /**
     * 查询账户信息并判断账户余额
     */
    Map<Long, TBizAcct> versionMap = new HashMap<>(); //版本号
    Iterator<Entry<Long, BigDecimal>> it = upAcctMap.entrySet().iterator();
    while (it.hasNext()) {
      Map.Entry<Long, BigDecimal> entry = it.next();
      if (entry.getValue().compareTo(BigDecimal.valueOf(0.00)) == 0) {
        it.remove();//使用迭代器的remove()方法删除元素
      } else {
        TBizAcct acct = repository.findById(entry.getKey()).get();
        if (BigDecimalUtil.add(entry.getValue(), acct.getAvailableBalance()).compareTo(BigDecimal.valueOf(0.00)) < 0) {
          throw new LoanException(BizExceptionEnum.BALANCE_ERROR,
              entry.getKey() + "_" + acct.getAvailableBalance() + "_" + entry.getValue().negate());
        }else{
          versionMap.put(entry.getKey(),acct);
        }
      }
    }

    /**
     * 插入交易流水
     */
    recordRepo.saveAll(recordList);

    /**
     * 更新账户余额（retry）
     */
    //TODO

    return true;
  }

}