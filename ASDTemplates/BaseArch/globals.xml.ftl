<?xml version="1.0"?>
<globals>
    <#assign useSupport=(minApiLevel lt 23)>
    <global id="topOut" value="." />
    <global id="projectOut" value="." />
    <global id="srcOut" value="${srcDir}/${slashedPackageName(packageName)}" />
    <global id="resOut" value="${resDir}" />
    <global id="mavenUrl" value="mavenCentral" />
    <global id="buildToolsVersion" value="23.0.2" />
    <global id="gradlePluginVersion" value="2.1.+" />
    <global id="enableProGuard" type="boolean" value="true" />
    <global id="buildApi" value="${buildApiString}" />

    <global id="manifestOut" value="${manifestDir}" />
    <global id="useSupport" type="boolean" value="${useSupport?string}" />
    <global id="SupportPackage" value="${useSupport?string('.support.v4','')}" />
    <global id="hasNoActionBar" type="boolean" value="false" />
    <global id="parentActivityClass" value="" />
    <global id="excludeMenu" type="boolean" value="true" />
    <global id="generateActivityTitle" type="boolean" value="false" />
    <#include "../common/common_globals.xml.ftl" />
</globals>
