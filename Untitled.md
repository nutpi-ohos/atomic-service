## pinyin

将中文转为拼音。不依赖任何三方库，几KB原生实现，有良好的兼容性，不挑运行环境。



## 安装

```nginx
ohpm install @nutpi/pinyin
```

## 使用

```js
// 引入拼音转换库
import PinyinConverter from '@nutpi/pinyin';

// 创建拼音转换器实例
const converter = new PinyinConverter();


@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  aboutToAppear(): void {

    this.message = converter.convert("坚果派")
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}
```

## 效果

![image-20241226232652114](https://luckly007.oss-cn-beijing.aliyuncs.com/nutpi/image-20241226232652114.png)



## 三方库地址

https://ohpm.openharmony.cn/#/cn/detail/@nutpi%2Fpinyin









# nutpi/axios

## 简介

HarmonyOS NEXT的axios网络库的模块儿化封装。网络通信是最常用的功能，之前有os.http包，但axios网络库更强大和好用。 然而，原始的axios库的使用方式较为繁琐，让人感到不够便捷。作为一位前期从事小程序开发的开发者，我深受小程序网络访问的简单性和便利性的吸引。因此，在HarmonyOS中打造一个最简单好用的网络访问组件。 让你一行代码写接口，一分钟写完一个接口。

- 基于 Promise 对象实现更简单的 request 使用方式，支持请求和响应拦截
- 支持全局挂载
- 支持多个全局配置实例
- 支持自定义验证器
- 支持自定义参数
- 支持拦截器
- 对参数的处理比uni.request 更强

## 下载安装

```shell
ohpm  install @nutpi/axios
```

关于axios封装更详细的介绍，请参考[HarmonyOS NEXT应用开发实战：一分钟写完一个网络接口](https://blog.csdn.net/yyz_1987/article/details/144803796)

## 三方库地址

https://ohpm.openharmony.cn/#/cn/detail/@nutpi%2Faxios





#  nutpi/request

#### 介绍

HarmonyOS NEXT 远场服务通信rcp模块儿化封装。网络通信是最常用的功能。之前有os.http包，但HarmonyOS远场服务通信服务(RCP)是华为主推的，更强大和高效。 然而原始的远场通信（RCP）使用方式较为繁琐，让人感到不够便捷。作为一位前期从事小程序开发的开发者，我深受小程序网络访问的简单性和便利性的吸引。因此，在HarmonyOS中打造一个最简单好用的网络访问组件。

![首页](https://luckly007.oss-cn-beijing.aliyuncs.com/nutpi/%E9%A6%96%E9%A1%B5.jpeg)

#### 软件架构

软件架构说明

## 特性介绍

- 基于 Promise 对象实现更简单的 request 使用方式，支持请求和响应拦截
- 支持全局挂载
- 支持多个全局配置实例
- 支持自定义验证器
- 支持文件上传/下载
- 支持自定义参数
- 支持拦截器
- 对参数的处理比uni.request 更强

## 下载安装

```
ohpm  install @nutpi/request
```

关于rcp封装更详细的介绍，请参考[HarmonyOS NEXT远场通信RCP简单好用的模块化封装](https://gitee.com/link?target=https%3A%2F%2Fblog.csdn.net%2Fyyz_1987%2Farticle%2Fdetails%2F143881288)

## 构建环境

DevEco Studio 5.0.1 Beta3，Build Version5.0.5.200 发布日期 2024/11/12

## 三方库地址

https://ohpm.openharmony.cn/#/cn/detail/@nutpi%2Frequest















## @nutpi/simple_permission

本开源工具库专注于鸿蒙应用开发，适配 API12 版本，提供了权限检查、权限申请功等功能。

## 模块介绍

### 权限模块

提供了一套简洁易用的权限申请与管理接口，方便开发者在应用中处理各种权限相关操作。涵盖了如相机、麦克风、存储等常见权限的申请、检查权限状态以及权限被拒绝后的处理逻辑。

## 如何使用本工具库

1. 安装依赖

   ```
   ohpm install @nutpi/simple_permission
   ```


2. 主要功能

   | 组成                  | 类型   | 说明               |
   | --------------------- | ------ | ------------------ |
   | PermissionManager     | class  | 封装权限相关的功能 |
   | checkPermission       | method | 检查是否拥有权限   |
   | requestPermission     | method | 申请权限           |
   | openPermissionSetting | method | 拉起权限设置页面   |

3. 签名

   ```typescript
   import { abilityAccessCtrl, bundleManager, common, Permissions } from '@kit.AbilityKit';
   
   /**
    * `PermissionManager` 类用于管理权限相关的操作。
    */
   export class PermissionManager {
     /**
      * 检查给定的权限列表是否都已被授予。
      *
      * @param {Permissions[]} permissions - 要检查的权限列表。
      * @returns {boolean} 如果所有权限都已被授予，则返回 `true`；否则返回 `false`。
      */
     static checkPermission(permissions: Permissions[]): boolean {
     }
   
     /**
      * 异步请求用户授予给定的权限列表。
      *
      * @param {Permissions[]} permissions - 要请求的权限列表。
      * @returns {Promise<boolean>} 如果成功获取所有请求权限的授权结果且都为成功授权（值为0），则返回 `true`；否则返回 `false`。
      */
     static async requestPermission(permissions: Permissions[]): Promise<boolean> {
     }
   
     /**
      * 异步打开权限设置页面以处理给定权限列表的授权情况。
      *
      * @param {Permissions[]} permissions - 要处理的权限列表。
      * @param {Context} [context] - 可选的上下文信息，如果未提供则尝试获取默认上下文。
      * @returns {Promise<boolean>} 如果成功打开权限设置页面并所有权限的授权结果都为 `PERMISSION_GRANTED`，则返回 `true`；否则返回 `false`。
      */
     static async openPermissionSetting(permissions: Permissions[], context?: Context) {
     }
   }
   ```

## 许可证

本开源工具库采用 [Apache License 2.0](https://gitee.com/link?target=https%3A%2F%2Fwww.apache.org%2Flicenses%2FLICENSE-2.0.html)
许可证，在拷贝和借鉴代码时，请大家务必注明出处。

## 联系我

1. 万少 微信 w846903522
2. 掘金 https://juejin.cn/user/4441682708283191
3. 邮箱 yeah126139163@163.com

## gitee

https://gitee.com/ukSir/simple_tool

