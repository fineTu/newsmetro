package com.newsmetro.service;

import com.newsmetro.dao.TargetGroupMapper;
import com.newsmetro.po.Target;
import com.newsmetro.po.TargetGroup;
import com.newsmetro.po.TargetGroupRel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by finetu on 5/28/15.
 */
@Service
public class TargetGroupService {
    @Autowired
    private TargetGroupMapper targetGroupMapper;

    public void save(TargetGroup targetGroup){
        targetGroupMapper.save(targetGroup);
    }

    public void delete(Long targetGroupId){
        targetGroupMapper.delete(targetGroupId);
    }

    public List<TargetGroup> findByUserId(Long userId){
        return targetGroupMapper.findByUserId(userId);
    }

    public void changePosition(TargetGroup targetGroup) {
        List<TargetGroup> groupList = targetGroupMapper.findByUserId(targetGroup.getUserId());

        for(int i=0;i<groupList.size();i++) {
            TargetGroup tg = groupList.get(i);
            if (tg.getId().equals(targetGroup.getId())) {
                groupList.remove(i);
                break;
            }
        }
        groupList.add(targetGroup.getPosition(),targetGroup);
        for(int i=0;i<groupList.size();i++) {
            TargetGroup tg = groupList.get(i);
            TargetGroup newTg = new TargetGroup();
            newTg.setId(tg.getId());
            newTg.setPosition(i+1);
            targetGroupMapper.update(newTg);
        }
    }

    public void update(TargetGroup targetGroup) {
        targetGroupMapper.update(targetGroup);
    }

    public void addToGroup(TargetGroupRel targetGroupRel){
        targetGroupMapper.addToGroup(targetGroupRel);
    }

    public void removeFromGroup( Long groupId, Long targetId){
        targetGroupMapper.removeFromGroup(groupId,targetId);
    }

    public List<Target> findTargetByGroupId(Long targetGroupId){
        return targetGroupMapper.findTargetByGroupId(targetGroupId);
    }


}
