package com.newsmetro.action;

import com.newsmetro.po.Target;
import com.newsmetro.po.TargetGroup;
import com.newsmetro.po.TargetGroupRel;
import com.newsmetro.po.User;
import com.newsmetro.service.TargetGroupService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * Created by finetu on 5/29/15.
 */

@Controller
public class TargetGroupAction extends BaseAction{
    @Autowired
    private TargetGroupService targetGroupService;

    @RequestMapping(value="/addTargetGroup.html")
    public String addTargetGroup(HttpServletRequest request,HttpServletResponse response,TargetGroup targetGroup) {
        if (targetGroup==null|| StringUtils.isBlank(targetGroup.getName())||targetGroup.getPosition()==null) {
            returnFail(response);
            return "myTargetList";
        }
        User user = (User) request.getSession().getAttribute("user");
        try {
            targetGroup.setName(new String(targetGroup.getName().getBytes("ISO-8859-1"),"utf-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        targetGroup.setStatus(1);
        targetGroup.setDescription("");
        targetGroup.setUserId(user.getId());
        targetGroup.setCreateTime(System.currentTimeMillis());
        targetGroupService.save(targetGroup);
        return "redirect:/myTargetList.html";
    }

    @RequestMapping(value="/addToGroup.html")
    public void addToGroup(HttpServletRequest request,HttpServletResponse response) {
        String targetIdStr = request.getParameter("targetId");
        String targetGroupIdStr = request.getParameter("targetGroupId");
        if (StringUtils.isBlank(targetIdStr)||StringUtils.isBlank(targetGroupIdStr)) {
            returnFail(response);
            return;
        }
        TargetGroupRel rel = new TargetGroupRel();
        rel.setTargetId(Long.parseLong(targetIdStr));
        rel.setTargetGroupId(Long.parseLong(targetGroupIdStr));
        List<Target> tpList = targetGroupService.findTargetByGroupId(rel.getTargetGroupId());
        rel.setPosition(tpList.size());
        rel.setCreateTime(System.currentTimeMillis());

        targetGroupService.addToGroup(rel);
        returnSucc(response);
        return;
    }

    @RequestMapping(value="/removeFromGroup.html")
    public void removeFromGroup(HttpServletRequest request,HttpServletResponse response) {
        String targetIdStr = request.getParameter("targetId");
        String targetGroupIdStr = request.getParameter("targetGroupId");
        if (StringUtils.isBlank(targetIdStr)||StringUtils.isBlank(targetGroupIdStr)) {
            returnFail(response);
            return;
        }
        TargetGroupRel rel = new TargetGroupRel();
        rel.setTargetId(Long.parseLong(targetIdStr));
        rel.setTargetGroupId(Long.parseLong(targetGroupIdStr));
        targetGroupService.removeFromGroup(rel.getTargetGroupId(), rel.getTargetId());
        returnSucc(response);
        return;
    }
}
