package com.zsy.loan.bean.enumeration;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public class BizTypeEnum {

  /**
   * 客户状态
   */
  public enum CustomerStatusEnum {
    /**
     * 正常:1,黑名单:2,删除:3
     */
    NORMAL(1), BLACKLIST(2), DELETE(3);

    private long value;

    private CustomerStatusEnum(long value) {
      this.value = value;
    }

    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }
  }

  /**
   * 客户类型
   */
  public enum CustomerTypeEnum {
    /**
     * 1:借款人账户,2:融资人账户
     */
    INVEST(1), LOAN(2);

    private long value;

    private CustomerTypeEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static CustomerTypeEnum getEnumByKey(long key) {
      CustomerTypeEnum[] array = CustomerTypeEnum.values();
      for (CustomerTypeEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 账户状态
   */
  public enum AcctStatusEnum {
    /**
     * 有效:1,冻结:2,止用:3
     */
    VALID(1), FREEZE(2), INVALID(3);

    private long value;

    private AcctStatusEnum(long value) {
      this.value = value;
    }

    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }
  }

  /**
   * 账户余额类型
   */
  public enum AcctBalanceTypeEnum {
    /**
     * 可透支:1,不可透支:2
     */
    OVERDRAW(1), NO_OVERDRAW(2);

    private long value;

    private AcctBalanceTypeEnum(long value) {
      this.value = value;
    }

    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }
  }

  /**
   * 账户类型
   */
  public enum AcctTypeEnum {
    /**
     * 1:公司卡账户,2:融资账户,3:借款人账户,4:代偿账户,5:暂收,6:暂付
     */
    COMPANY(1), INVEST(2), LOAN(3), REPLACE(4), INTERIM_IN(5),INTERIM_OUT(6);

    private long value;

    private AcctTypeEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static AcctTypeEnum getEnumByKey(long key) {
      AcctTypeEnum[] array = AcctTypeEnum.values();
      for (AcctTypeEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 借据状态
   */
  public enum LoanStatusEnum {
    /**
     * 1:登记,2:已放款,3:还款中,4:已逾期,5:已展期,6:已结清,7:已代偿,8:已终止
     */
    CHECK_IN(1), PUT(2), REPAY_IND(3), OVERDUE(4), DELAY(5),SETTLE(6),COMPENSATION(7),END(8);

    private long value;

    private LoanStatusEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static LoanStatusEnum getEnumByKey(long key) {
      LoanStatusEnum[] array = LoanStatusEnum.values();
      for (LoanStatusEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 借据凭证类型
   */
  public enum LoanVoucherTypeEnum {
    /**
     * 1:身份证,2:电子合同,3:房本,4:解押手续
     */
    ID_CARD(1), CONTRACT(2), HOUSE_CERT(3), REMOVE_MORTGAGE_BOOK(4);

    private long value;

    private LoanVoucherTypeEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static LoanVoucherTypeEnum getEnumByKey(long key) {
      LoanVoucherTypeEnum[] array = LoanVoucherTypeEnum.values();
      for (LoanVoucherTypeEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 还款状态
   */
  public enum RepayStatusEnum {
    /**
     * 1:待还,2:已还,3:已逾期,4:已代偿,5:已终止
     */
    NOT_REPAY(1), REPAID(2), OVERDUE(3), COMPENSATION(4), END(5);

    private long value;

    private RepayStatusEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static RepayStatusEnum getEnumByKey(long key) {
      RepayStatusEnum[] array = RepayStatusEnum.values();
      for (RepayStatusEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 资金类型
   */
  public enum AmtTypeEnum {
    /**
     * 1:本金,2:利息,3:罚息,4:服务费,5:活期利息,6:资金
     */
    CAPITAL(1), INTEREST(2), BREACH_INTEREST(3), SERVICE_FEE(4), PASS_INTEREST(5),FUNDS(6);

    private long value;

    private AmtTypeEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static AmtTypeEnum getEnumByKey(long key) {
      AmtTypeEnum[] array = AmtTypeEnum.values();
      for (AmtTypeEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 业务类型
   */
  public enum LoanBizTypeEnum {
    /**
     * 1:放款,2:还款,3:服务费收取,4:服务费补偿,5:支出,6:融资,7:撤资,8:收入,9:资金登记,10:转账,11:提现,12:结转,13:代偿,14:提前还款
     */
    PUT(1), REPAY(2), SERVICE_FEE_IN(3), SERVICE_FEE_OUT(4), OUT(5),INVEST(6),DIVESTMENT(7),IN(8),FUNDS_CHECK_IN(9)
    ,TRANSFER(10),WITHDRAW(11),SETTLEMENT(12),COMPENSATION(13),PREPAYMENT(14);

    private long value;

    private LoanBizTypeEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static LoanBizTypeEnum getEnumByKey(long key) {
      LoanBizTypeEnum[] array = LoanBizTypeEnum.values();
      for (LoanBizTypeEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }


  /**
   * 融资状态
   */
  public enum InvestStatusEnum {
    /**
     * 1:登记,2:计息中,3:已延期,4:已撤资,5:已结转
     */
    CHECK_IN(1), INTEREST_ING(2), DELAY(3), DIVESTMENT(4), SETTLEMENT(5);

    private long value;

    private InvestStatusEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static InvestStatusEnum getEnumByKey(long key) {
      InvestStatusEnum[] array = InvestStatusEnum.values();
      for (InvestStatusEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 回款状态
   */
  public enum InvestPlanStatusEnum {
    /**
     * 1:未计息,2:已计息,3:已结息,4:已终止
     */
    UN_INTEREST(1), INTERESTED(2), RECEIVING(3), END(4);

    private long value;

    private InvestPlanStatusEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static InvestPlanStatusEnum getEnumByKey(long key) {
      InvestPlanStatusEnum[] array = InvestPlanStatusEnum.values();
      for (InvestPlanStatusEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 处理状态
   */
  public enum ProcessStatusEnum {
    /**
     * 1:成功,2:失败,0:处理中
     */
    SUCCESS(1), FAIL(2), ING(0);

    private long value;

    private ProcessStatusEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static ProcessStatusEnum getEnumByKey(long key) {
      ProcessStatusEnum[] array = ProcessStatusEnum.values();
      for (ProcessStatusEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 收支用途
   */
  public enum InOutTypeEnum {
    /**
     * 1:一般预算支出,2:办公支出,3:其他支出,4:股东分润,5:对公支出,6:对公收入,7:利息收入
     */
    GENERAL(1), OFFICE(2), OTHER(3), SPLITTING(4), PUBLIC_OUT(5),PUBLIC_IN(6),INTEREST(7);

    private long value;

    private InOutTypeEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static InOutTypeEnum getEnumByKey(long key) {
      InOutTypeEnum[] array = InOutTypeEnum.values();
      for (InOutTypeEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }

  /**
   * 转账用途
   */
  public enum TransferTypeEnum {
    /**
     * 1:账户调整,2:服务费补偿,3:融资人贴息,4:其他
     */
    ADJUST(1), COMPENSATE(2), DISCOUNT(3), OTHER(4);

    private long value;

    private TransferTypeEnum(long value) {
      this.value = value;
    }

    @JsonValue
    public long getValue() {
      return value;
    }

    public void setValue(long value) {
      this.value = value;
    }

    @JsonCreator
    public static TransferTypeEnum getEnumByKey(long key) {
      TransferTypeEnum[] array = TransferTypeEnum.values();
      for (TransferTypeEnum item : array) {
        if (item.getValue() == key) {
          return item;
        }
      }
      return null;
    }

  }


}
