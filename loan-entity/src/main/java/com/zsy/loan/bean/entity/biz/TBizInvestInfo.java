package com.zsy.loan.bean.entity.biz;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 *
 *
 * @Author zhangxh
 * @Date 2019-01-18  12:30
 */
@Entity
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "t_biz_invest_info", schema = "loan", catalog = "")
public class TBizInvestInfo {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(name = "id")
  private long id;

  @Basic
  @Column(name = "org_no")
  private long orgNo;

  @Basic
  @Column(name = "user_no")
  private long userNo;

  @Basic
  @Column(name = "in_acct_no")
  private long inAcctNo;

  @Basic
  @Column(name = "external_acct")
  private String externalAcct;

  @Basic
  @Column(name = "prin")
  private BigDecimal prin;

  @Basic
  @Column(name = "acct_date")
  private Date acctDate;

  @Basic
  @Column(name = "begin_date")
  private Date beginDate;

  @Basic
  @Column(name = "end_date")
  private Date endDate;

  @Basic
  @Column(name = "rate")
  private BigDecimal rate;

  @Basic
  @Column(name = "term_no")
  private Long termNo;

  @Basic
  @Column(name = "cycle_interval")
  private long cycleInterval;

  @Basic
  @Column(name = "status")
  private long status;

  @Basic
  @Column(name = "dd_date")
  private Long ddDate;

  @Basic
  @Column(name = "extension_no")
  private Long extensionNo;

  @Basic
  @Column(name = "extension_rate")
  private BigDecimal extensionRate;

  @Basic
  @Column(name = "tot_schd_bigint")
  private BigDecimal totSchdBigint;

  @Basic
  @Column(name = "tot_paid_prin")
  private BigDecimal totPaidPrin;

  @Basic
  @Column(name = "tot_paid_bigint")
  private BigDecimal totPaidBigint;

  @Basic
  @Column(name = "tot_wav_amt")
  private BigDecimal totWavAmt;

  @Basic
  @Column(name = "operator")
  private long operator;

  @Basic
  @Column(name = "create_at")
  private Timestamp createAt;

  @Basic
  @Column(name = "update_at")
  private Timestamp updateAt;

  @Override
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (o == null || getClass() != o.getClass()) {
      return false;
    }

    TBizInvestInfo that = (TBizInvestInfo) o;

    if (id != that.id) {
      return false;
    }
    if (orgNo != that.orgNo) {
      return false;
    }
    if (userNo != that.userNo) {
      return false;
    }
    if (inAcctNo != that.inAcctNo) {
      return false;
    }
    if (cycleInterval != that.cycleInterval) {
      return false;
    }
    if (status != that.status) {
      return false;
    }
    if (operator != that.operator) {
      return false;
    }
    if (externalAcct != null ? !externalAcct.equals(that.externalAcct)
        : that.externalAcct != null) {
      return false;
    }
    if (prin != null ? !prin.equals(that.prin) : that.prin != null) {
      return false;
    }
    if (acctDate != null ? !acctDate.equals(that.acctDate) : that.acctDate != null) {
      return false;
    }
    if (beginDate != null ? !beginDate.equals(that.beginDate) : that.beginDate != null) {
      return false;
    }
    if (endDate != null ? !endDate.equals(that.endDate) : that.endDate != null) {
      return false;
    }
    if (rate != null ? !rate.equals(that.rate) : that.rate != null) {
      return false;
    }
    if (termNo != null ? !termNo.equals(that.termNo) : that.termNo != null) {
      return false;
    }
    if (ddDate != null ? !ddDate.equals(that.ddDate) : that.ddDate != null) {
      return false;
    }
    if (extensionNo != null ? !extensionNo.equals(that.extensionNo) : that.extensionNo != null) {
      return false;
    }
    if (extensionRate != null ? !extensionRate.equals(that.extensionRate)
        : that.extensionRate != null) {
      return false;
    }
    if (totSchdBigint != null ? !totSchdBigint.equals(that.totSchdBigint)
        : that.totSchdBigint != null) {
      return false;
    }
    if (totPaidPrin != null ? !totPaidPrin.equals(that.totPaidPrin) : that.totPaidPrin != null) {
      return false;
    }
    if (totPaidBigint != null ? !totPaidBigint.equals(that.totPaidBigint)
        : that.totPaidBigint != null) {
      return false;
    }
    if (totWavAmt != null ? !totWavAmt.equals(that.totWavAmt) : that.totWavAmt != null) {
      return false;
    }
    if (createAt != null ? !createAt.equals(that.createAt) : that.createAt != null) {
      return false;
    }
    if (updateAt != null ? !updateAt.equals(that.updateAt) : that.updateAt != null) {
      return false;
    }

    return true;
  }

  @Override
  public int hashCode() {
    int result = (int) (id ^ (id >>> 32));
    result = 31 * result + (int) (orgNo ^ (orgNo >>> 32));
    result = 31 * result + (int) (userNo ^ (userNo >>> 32));
    result = 31 * result + (int) (inAcctNo ^ (inAcctNo >>> 32));
    result = 31 * result + (externalAcct != null ? externalAcct.hashCode() : 0);
    result = 31 * result + (prin != null ? prin.hashCode() : 0);
    result = 31 * result + (acctDate != null ? acctDate.hashCode() : 0);
    result = 31 * result + (beginDate != null ? beginDate.hashCode() : 0);
    result = 31 * result + (endDate != null ? endDate.hashCode() : 0);
    result = 31 * result + (rate != null ? rate.hashCode() : 0);
    result = 31 * result + (termNo != null ? termNo.hashCode() : 0);
    result = 31 * result + (int) (cycleInterval ^ (cycleInterval >>> 32));
    result = 31 * result + (int) (status ^ (status >>> 32));
    result = 31 * result + (ddDate != null ? ddDate.hashCode() : 0);
    result = 31 * result + (extensionNo != null ? extensionNo.hashCode() : 0);
    result = 31 * result + (extensionRate != null ? extensionRate.hashCode() : 0);
    result = 31 * result + (totSchdBigint != null ? totSchdBigint.hashCode() : 0);
    result = 31 * result + (totPaidPrin != null ? totPaidPrin.hashCode() : 0);
    result = 31 * result + (totPaidBigint != null ? totPaidBigint.hashCode() : 0);
    result = 31 * result + (totWavAmt != null ? totWavAmt.hashCode() : 0);
    result = 31 * result + (int) (operator ^ (operator >>> 32));
    result = 31 * result + (createAt != null ? createAt.hashCode() : 0);
    result = 31 * result + (updateAt != null ? updateAt.hashCode() : 0);
    return result;
  }
}