package com.newsmetro.dao;

import com.newsmetro.po.TargetGroup;
import com.newsmetro.po.TargetGroupRel;
import com.newsmetro.po.Target;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by finetu on 5/28/15.
 */
public interface TargetGroupMapper {
    void save(TargetGroup targetGroup);
    void delete(@Param("targetGroupId") Long targetGroupId);
    List<TargetGroup> findByUserId(@Param("userId") Long userId);
    void update(@Param("targetGroup") TargetGroup targetGroup);

    List<Target> findTargetByGroupId(@Param("targetGroupId") Long targetGroupId);
    void addToGroup(TargetGroupRel targetGroupRel);
    void removeFromGroup(@Param("targetGroupId") Long targetGroupId,@Param("targetId") Long targetId);

}