﻿<?xml version="1.0" encoding="utf-8"?>

<hibernate-mapping xmlns="urn:nhibernate-mapping-2.2">
  <class name="$rootnamespace$.Models.User, $rootnamespace$" table="users">
    <id name="Id">
      <generator class="identity" />
    </id>

    <many-to-one name="Status" column="StatusId" not-null="false" />
    <many-to-one name="Profile" column="UserProfileId" not-null="false" />

    <property name="Name" length="100" not-null="true" />
    <property name="Login" length="20" not-null="true" unique="true" index="idx_users_login" />
    <property name="Password" length="50" not-null="true" index="idx_users_password" />
    <property name="Email" length="100" />
    <property name="Created" not-null="true" />
    <property name="Updated" not-null="true" />
  </class>
  <query name="users-find-by-login-password">
    <![CDATA[
      from User u where lower(u.Login) = :login and u.Password = :password and u.Status = :status
      ]]>
  </query>
  <query name="users-allow-access">
    <![CDATA[
      select f from User u join u.Profile.Functionalities f where u.Id = :id and lower(f.Controller) = :controllerName and lower(f.Action) = :actionName
      ]]>    
  </query>
</hibernate-mapping>