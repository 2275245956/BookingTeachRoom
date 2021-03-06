class ApiAddress {
  // API地址
  static const String DEFAULT_BIZ_API_URL =
    "http://122.51.225.40:8080/lams";//  "http://192.168.0.7:8080/";//"http://122.51.225.40:8088";// "http://wtik54.natappfree.cc/";//"http://wvun7x.natappfree.cc"; //
  static const String DEFAULT_UPDATE_URL = "";

  ///SystemConifg
  static const String SCHEDULE_CONFIG="/saveOrUpdateSchdule";
  static const String GETSYSTEM_CONFIGBYKEY="/getSettingValue";

  static const String GETALLUSER="/sysAdmin/likeQueryUserInfo";
  static const String DELETEUSER="/sysAdmin/delSysUser";
  static const String UPDATEUSER="/sysAdmin/upSysUser";
  static const String ADDUSER="/sysAdmin/addSysUser";
  static const String ADDLAMB="/sysAdmin/addRoomInfo";
  static const String ALLLAMS="/sysAdmin/selectAllRoomInfo";
  static const String UPDATELMABINFO="/sysAdmin/upRoomInfo";
  static const String DELETELAMB="/sysAdmin/delRoomInfo";

  ///实验室申请=======================================教师
  static const String GET_EMPTYLAM="/tea/findEmptyRoom";
  static const String SAVE_APPLYINFO="/tea/commitExpApply";
  static const String SAVE_APPLYINFOS="/tea/commitExpApplys";
  static const String GETTechAll_RECORDS="/tea/queryExpApplyByTeaNumAndStatus";
  static const String GET_RECORDS_keywords="/tea/likeQueryExpApplyByTeaNum";
  static const String CANCEL_LAMB="/tea/updateTeaApplyStatus";
  static const String GetAllStudentApplying="/tea/auditingApply";
  static const String GetAllStudentApplyed="/tea/auditedApply";
  static const String CHECKStuApply="/tea/updateStuApplyStatus";
  ///=========================================实验室管理员
  static const String GETALLTEACH_APPLYLAM="/expAdmin/selectAllTeaExpApply";
  static const String CheckTeacherApply="/expAdmin/updateTeaApplyStatus";
  static const String GETALLTEACHERPASSEDSTU="/expAdmin/selectAllStuExpApply";
 static const String CHECKSTUAPPLY="/expAdmin/updateStuApplyStatus";
  ///学生实验操作
  static const String GETALLPASSEDLAMS="/stu/findAllCanApplyExp";
  static const String STUAPPLYLAMB="/stu/applyExp";
  static const String STUCANCELAPPLY="/stu/cancelApply";
  static const String STUAPPLYRECORD="/stu/findExpStatus";
  ///Common url
  static const String USER_LOGIN="/login";
  static const String CHANGEPWD="/common/changePass";
  static const String GETALL_LAMBNAME="/tea/selectAllExp";
  static const String GETAllPassedLamInfoByTNumber="/common/likeQueryExpApplyT";
  static const String UPFILE="/import";
  static const String GetExpModel="/common/getExpDetailByT";
  static const String GetTodaysTask="/common/getExpInfo";
  static const String GetAllCheckStuByStatus="/common/likeQueryExpApplyS";


  ///消息接口
  static  const String GetAllMessage="/push/findPushInfoByAccount";
 static const  String ReadMessage="/push/updateReaded";

  // 权限相关API
  //static const String  SUPPLIER_INFO_ALL = "api/supplier/all";

  //----------隐患治理----------

}
