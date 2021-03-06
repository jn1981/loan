package com.zsy.loan.admin.modular.system.controller;

import com.zsy.loan.admin.core.base.controller.BaseController;
import com.zsy.loan.bean.entity.system.Cfg;
import com.zsy.loan.dao.system.CfgRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * CfgController
 *
 * @author enilu
 * @version 2018/8/9 0009
 */

@Controller
@RequestMapping("/cfg")
public class CfgController extends BaseController {

  @Autowired
  private CfgRepository cfgRepository;
  private static String PREFIX = "/system/cfg/";

  /**
   * 跳转到参数首页
   */
  @RequestMapping("")
  public String index() {
    return PREFIX + "cfg.html";
  }

  /**
   * 跳转到添加参数
   */
  @RequestMapping("/cfg_add")
  public String orgAdd() {
    return PREFIX + "cfg_add.html";
  }

  /**
   * 跳转到修改参数
   */
  @RequestMapping("/cfg_update/{cfgId}")
  public String orgUpdate(@PathVariable Long cfgId, Model model) {
    Cfg cfg = cfgRepository.findOne(cfgId);
    model.addAttribute("item", cfg);
    return PREFIX + "cfg_edit.html";
  }

  /**
   * 获取参数列表
   */
  @RequestMapping(value = "/list")
  @ResponseBody
  public Object list() {
    return cfgRepository.findAll();
  }

  /**
   * 新增参数
   */
  @RequestMapping(value = "/add")
  @ResponseBody
  public Object add(Cfg cfg) {
    cfgRepository.save(cfg);
    return SUCCESS_TIP;
  }

  /**
   * 删除参数
   */
  @RequestMapping(value = "/delete")
  @ResponseBody
  public Object delete(@RequestParam Long cfgId) {
    cfgRepository.delete(cfgId);
    return SUCCESS_TIP;
  }

  /**
   * 修改参数
   */
  @RequestMapping(value = "/update")
  @ResponseBody
  public Object update(Cfg cfg) {
    cfgRepository.save(cfg);
    return SUCCESS_TIP;
  }

  /**
   * 参数详情
   */
  @RequestMapping(value = "/detail/{cfgId}")
  @ResponseBody
  public Object detail(@PathVariable("cfgId") Long cfgId) {
    return cfgRepository.findOne(cfgId);
  }

}