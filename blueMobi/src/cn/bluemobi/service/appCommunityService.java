package cn.bluemobi.service;

import java.util.List;
import java.util.Map;

import cn.bluemobi.entity.app.TieziInfo;

public interface appCommunityService {
	/**
     * 
     * Description: 创建圈子<br/>
     *
     * @author 丁鹏
     * @return
     */
    Map<String, Object> createCommunuty(Map<String, Object> paramMap);
    
    /**
     * 
     * Description: 分页获取帖子列表<br/>
     *
     * @author 丁鹏
     * @return
     */
    List<TieziInfo> getTeiziListByFenYe();
}
