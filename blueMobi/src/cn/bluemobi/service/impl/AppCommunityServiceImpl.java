package cn.bluemobi.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.bluemobi.entity.app.TieziInfo;
import cn.bluemobi.mapper.app.AppCommunityMapper;
import cn.bluemobi.service.appCommunityService;

@Service
public class AppCommunityServiceImpl implements appCommunityService {

	@Autowired
    private AppCommunityMapper mapper;
	
	@Override
	public Map<String, Object> createCommunuty(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		mapper.addCommunity(paramMap);
		return paramMap;
	}

	@Override
	public List<TieziInfo> getTeiziListByFenYe() {
		return mapper.getTeiziListByFenYe();
	}

}
