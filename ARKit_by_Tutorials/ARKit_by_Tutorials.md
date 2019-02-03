《ARKit by Tutorials》笔记

---------------

**开发环境**

Xcode 10  Swift 4.2

macOS 10.13.4 +

iOS 12.0 +

ARKit 2.0





# Section I:入门ARKit





## 1-Hello ARKit

增强现实（AR）技术无疑将在我们的数字演化中发挥重要作用，因为它开始将科幻小说变成科学事实。 再加上最近对人工智能（AI）的兴趣激增 - 特别是机器学习 - 我们才刚刚开始了解这些技术如何协同工作以将现实世界与数字世界无缝融合。



### 增强现实

虽然很酷，但AR并不是一种绝地技巧。相反，幻觉来自于将虚拟内容叠加在来自相机的实时图像馈送之上。也就是说，AR增强（增强）现实世界（现实）。为了使幻觉无缝，虚拟内容的位置，比例和旋转在设备移动通过真实世界空间时不断使用来自设备的实时运动数据。
最终的结果？让您质疑自己的现实的令人兴奋的效果。我们来看看它是如何工作的。

#### 基于标记的跟踪

AR不是一个新概念;许多现代的，配备相机的智能设备已经能够在过去几年中实现这一目标。这通常通过使用跟踪卡和称为基于标记的增强现实技术来实现。
跟踪卡用作真实世界表面上的锚点;并且一种特殊的算法分析相机数据以确定卡的位置，比例和方向。然后，该跟踪信息用于投影，缩放和放置3D内容，3D内容叠加在相机的图像上。一个很好的例子是Om Nom Candy Flick，一款令人惊喜的有趣的增强现实游戏。

![image-20190121204605458](https://ws4.sinaimg.cn/large/006tNc79gy1fzelekvcofj30h60ayqdc.jpg)

不幸的是，当卡片离开相机视图时，跟踪会丢失，从而破坏整个AR体验。 AR的下一个前沿 - 我们现在所处的位置 - 是创建不需要跟踪物理标记的AR内容。

#### 无标记跟踪

想象一下，你有一副神奇的眼镜，可以在你看到的所有东西上叠加虚拟3D元素。如果你戴上它们，你可以将你的真实世界体验与内容完美地融合在一起，让一切看起来都很真实，你几乎可以触及它！
好吧，我会告诉你一个小秘密：那些神奇的眼镜已经存在，其中一个例子是微软HoloLens。

![image-20190121204723179](https://ws1.sinaimg.cn/large/006tNc79gy1fzelesr9dfj30gm07g0ut.jpg)

 然而，HoloLens远非神奇。相反，它是一种高度复杂的设备，能够跟踪您的一举一动。它也具有空间意识，这意味着它不仅可以看到，而且可以了解周围的世界。它通过真实世界空间跟踪运动并主动绘制环境，创建虚拟3D“世界空间”。

由于HoloLens是可穿戴设备，因此标准的人机界面（例如操纵杆或鼠标）不能很好地用于输入。因此，Microsoft提出了一些聪明的方法让用户与虚拟内容进行交互：

![image-20190121204831851](https://ws3.sinaimg.cn/large/006tNc79gy1fzelewbg8uj30m606ugn2.jpg)



- 凝视(Gaze)：使用放置在显示器中间的焦点立方体，其作用类似于虚拟鼠标光标。 您可以倾斜头部以将光标移动到对象顶部以便与它们进行交互。

- 手势(Gesture)：HoloLens可以识别用手做出的捏动手势
  模拟鼠标点击。
- 语音(Voice)：您也可以向HoloLens发出命令，就像使用Siri或Microsoft Xbox Connect一样。

HoloLens是一款出色的设备，但它并不完美。 它很大而且很笨重，它与我们在科幻故事中承诺的运动型太阳镜式耳机相去甚远。 此外，该设备仍然相当昂贵，这使得该技术对大多数人来说是遥不可及的。

然而，当Apple宣布ARKit时，这些进入壁垒已经解散。



### 介绍ARKit

ARKit是Apple的移动AR开发框架。有了它，您可以创建身临其境，引人入胜的体验，将虚拟2D和3D内容与您周围世界的实时摄像头相结合。
ARKit与其他AR框架（例如[Vuforia](https://www.vuforia.com)）的区别在于ARKit执行无标记跟踪。那就对了！不需要跟踪卡。最重要的是，ARKit立即将任何带有A9或更高处理器的Apple设备转换为无标记的AR设备。想一想 - 在这个时刻，数以百万计的Apple用户已经拥有了一个复杂的AR设备。

### ARKit能为您做什么？

如果您使用过Apple的其他任何框架，那么您可能期望需要很长时间才能完成工作。但是使用ARKit，它只需要几行代码 -  ARKit为您完成了大部分繁重的工作，因此您可以专注于重要的事情：创建身临其境且引人入胜的AR体验。
让我们来看看ARKit能为您做些什么。

#### 跟踪

与HoloLens类似，ARKit通过真实世界空间实时跟踪设备移动。它使用来自设备的采样运动数据来自动更新虚拟内容变换。它通过在虚拟场景中移动虚拟摄像机的视点来匹配设备的视点。



#### 2D图像和3D物体检测

ARKit可以检测2D图像和3D对象，允许您在对象上叠加增强内容，如经典艺术作品。现在你可以给蒙娜丽莎一个微笑 - 迈克尔安吉洛大卫的裤子怎么样？ ：]

#### 场景理解和持久性

为了实现无标记跟踪，ARKit创建并管理其自己的检测到的曲面的世界地图。每当检测到新曲面，修改曲面或移除曲面时，ARKit中的特殊事件挂钩都会触发。这使您可以对场景进行令人难以置信的控制，包括内容与这些曲面的交互方式。
ARKit还可以加载和保存世界地图，以便快速识别以前的扫描空间。通过在多个设备上加载相同的世界地图，您可以轻松地创建基本网络的共享体验。
您还可以在多个ARKit会话中保持虚拟放置内容的持久性。现在告诉我在哪里再放一次我的杯子？

#### 光估计

ARKit使用当前视频帧实时估计环境照明条件。然后，如果您的虚拟内容使用基于物理的材料，它可以自动调整虚拟内容的亮度级别以匹配环境条件，您将在后面的章节中了解这些内容。

#### 实时环境地图

ARKit可以通过对您的直接空间进行采样来生成实时环境地图。这使您可以为基于PBR的对象提供逼真的反射，以及实时照明信息。

#### 场景互动

ARKit还提供了命中测试功能，可让您以不受限制的方式与场景中的3D内容进行交互。您还可以将此交互与传统的基于触摸的手势结合起来，这是Apple在其基于AR的应用程序的人机界面指南中所推荐的。但是，因为你在Apple的生态系统中，所以没有什么可以阻止你使用Apple的其他很棒的框架，比如Core ML或Vision。您甚至可以使用SiriKit并用您的声音来指挥AR体验！

#### 度量缩放系统
为了计算场景中的距离和大小，ARKit使用相当精确的度量标度缩放系统。无论你使用哪种图形API  - 在ARKit中，1个单位等于1米。

#### 渲染集成

ARKit没有自己的图形API;它只为您提供**跟踪信息**和**表面检测**功能。虽然您仍然可以在场景中提供图形，但ARKit可以轻松地与SpriteKit，SceneKit和Metal等图形框架集成。
Apple与游戏开发社区的关系也为流行的游戏引擎Unity和Unreal带来了一些出色的插件。

![image-20181205234147391](https://ws4.sinaimg.cn/large/006tNbRwgy1fxwar9cg4kj30ta08ydjj.jpg)



### ARKit的局限性

虽然ARKit为移动设备上的用户体验提供了一种新的范例，但它有一些限制性质会影响您开发ARKit应用程序的方式。
让我们来看看ARKit的一些局限性。

#### 表面检测需要时间

表面检测和现实世界的理解需要相当长的时间 —— 这几乎不是即时的。因此，您需要管理用户期望并引导他们完成应用程序的表面检测阶段。否则，您的应用程序将很快收到装箱！



#### 运动处理滞后

过多的设备运动可能会导致卡顿和图像模糊，这使得ARKit难以理解它所看到的内容。当现实场景变得不稳定时，ARKit处理也会有点不稳定。在那些颠簸的道路上缓慢行驶非常重要。

#### 弱光条件

弱光条件是有问题的。设备上的摄像机无法识别低光场景以及人眼，这意味着ARKit将在低光条件下进行场景检测。它甚至可能根本无法识别任何表面。
如果你在光线不足的情况下努力寻找东西，那么ARKit发现它的情况要差十倍。

#### 光滑无纹理表面

光滑，无纹理的表面使ARKit难以检测和跟踪表面。表面纹理越多，ARKit就越容易检测和跟踪这些表面的运动。
作为开发人员，您的工作是确保用户在使用支持AR的应用之前了解这一点，否则当他们无法在抛光的黑色大理石地板上放置虚拟家具时，他们会感到沮丧。

#### 鬼影(Ghost effect)

使用AR一段时间之后，您可能会注意到某些虚拟内容违反了物理定律。例如，虚拟内容可能会穿过真实世界的物体，就像幽灵会通过一扇关闭的门一样。
由于这样的情况可能会打破AR体验，因此鼓励用户在宽敞的空间或干净的桌子上使用您的应用程序是一个好主意。



### ARKit背后的技术

当您看一下ARKit的内幕时，您可能会惊讶于某些技术非常熟悉并且已经存在了一段时间。

![image-20181206083547979](https://ws4.sinaimg.cn/large/006tNc79gy1fzelf2riguj30uq0b2goh.jpg)

ARKit使用 **Visual Inertial Odometry**（VIO）来跟踪设备及其周围世界的运动。 VIO将来自摄像机传感器的基于AVFoundation的输入与通过CoreMotion捕获的设备运动数据融合在一起。如果您之前使用过这些框架中的任何一个，您将立即发现它们如何协同工作以支持ARKit的场景识别和跟踪。

### 挑战

欢迎来到您的第一个挑战部分！你可能在这本书中很快就没想到会遇到什么挑战，是吗？
完成本书中的挑战将为您的ARKit之旅提供良好的服务。这些挑战让您有机会运用您的知识，并确保您在继续学习之前掌握了这些概念。如果您尝试挑战并且真的遇到困难，请不要担心，项目文件中提供了解决方案。
由于这是您的第一个挑战，我们已经做到了简单：快速阅读以下资源，并为它们添加书签。因为单凭谷歌搜索在ARKit上找到资源可能很困难，所以我们为您策划了一个列表。



#### 官方ARKit文档

这是Apple的ARKit文档官方网站。在这里，您可以找到有关ARKit及其相关技术的最新信息。
•ARKit的Apple开发人员文档：http://apple.co/2sE0rUq

#### 增强现实的人机界面指南

Apple还提供了一套人机界面指南，以指导您设计ARKit应用程序时的最佳实践。本指南向您展示了该做什么 - 以及不该做什么。不遵守这些准则可能会导致Apple拒绝您的应用提交。
•AR的人机界面指南：http：//apple.co/2xOwp1Q ARKit官方

#### WWDC 2017/2018视频

Apple总是在他们的WWDC演示文稿中包含大量信息 - 他们在ARKit上的视频也不例外，绝对值得观看不止一次。
•推出ARKit  -  iOS增强现实（2017）：http：//apple.co/2t4UPlA
•ARKit 2中的新功能：https：//apple.co/2xYvS2l
•了解ARKit跟踪和检测：https：//apple.co/2vI9Xsx
•使用SpriteKit超越2D（2017）：http：//apple.co/2jek9pz
•SceneKit  - 最新消息（2017）：http：//apple.co/2hTdRI3
•ARKit 2（2018）的新功能：https：//apple.co/2xYvS2l
•了解ARKit跟踪和检测（2018）：https：//apple.co/2vI9Xsx

#### 与ARKit交互式内容

这是Apple的官方ARKit演示之一，这是一个有趣的方式来获得ARKit的实践经验。按照链接查找“下载示例代码”按钮。找到后，下载zip文件，提取内容并使用最新版本的Xcode构建项目。然后，在具有A9处理器或更好处理器的物理设备上运行它（iPhone SE，iPhone 6s和更高版本）。目前，您无法在模拟器上测试AR应用。
在这个演示中，你将会遇到变色龙Elon，但要小心 - 他总是在看！

使用ARKit的互动内容：http：//apple.co/2yI4gi2
在本演示中，您将学习有关创建共享AR体验的所有信息。

•SwiftShot内部 - 创建AR游戏：https：//apple.co/2McZ9NA

### 关键点
您已经到了第一章的末尾，迈出了创建自己的支持AR的游戏和应用程序的第一步。
以下是您在本章中所做的快速回顾：
•您了解了增强现实是什么以及智能设备如何使用其板载摄像头和运动传感器来实现AR。
•您发现了基于标记的跟踪和无标记跟踪之间的差异。
•您被介绍给ARKit。 你了解它是什么，它做了什么，以及它的一些局限性。
•您了解到ARKit不是图形库; 相反，它是一个框架，可以为您带来繁重的AR。
在下一章中，您将学习如何使用Xcode创建第一个ARKit应用程序。 再见！



## 2-第一个ARKit应用



### 开始



![image-20190121210712987](https://ws2.sinaimg.cn/large/006tNc79gy1fzelf5pnq0j30j80dwdhy.jpg)



![屏幕快照 2019-01-21 下午9.01.44](https://ws1.sinaimg.cn/large/006tNc79gy1fzelf7lyzuj314k0t4jwt.jpg)

**ARPokerDice**

**SceneKit**



默认的模板已经有个简单的AR项目。



花一点时间来测试一下。 将相机对准一个空旷的空间，然后四处走动，直到看到巨型宇宙飞船。 尝试查看该工艺的所有可能角度。 您是否注意到宇宙飞船如何在现实世界中停留？ 这就是ARKit的神奇之处！

![IMG_BE1D02C5EACC-1](https://ws3.sinaimg.cn/large/006tNc79gy1fzelfa1du0j30hb09q7a3.jpg)

当您启动应用程序时，ARKit会将设备在空间中的当前位置用作其世界锚点。 然后加载SceneKit场景并将场景放入增强空间; 这是一种快速而肮脏的方式来获取AR中显示的任何内容。
好的 - 是时候放下你的宇宙飞船，孩子们。 还有很多事情要做。



#### 回顾这个默认项目

`ARSCNView`  它允许您在相机的实时背景图像上叠加3D场景。 它提供了ARKit和SceneKit之间的无缝集成。

> 注意：还有一个专门用于ARKit和SpriteKit集成的视图类：`ARSKView`。 如果您计划使用2D SpriteKit内容而不是3D SceneKit相关内容，则可以使用此视图类。



`ARSCNViewDelegate` 包含您可以实现的方法，以将您的SceneKit内容与您的AR会话同步。

##### **The SceneKit asset catalog**

这是为SceneKit资产明确设计的特殊文件夹。 SceneKit是一个强大的高级图形框架，能够创建和管理应用程序的所有图形和音频内容; 这是您存储场景，纹理，3D模型，动画，声音效果和音乐等内容的地方。

如果你双击art.scnassets / ship.scn，你会看到之前的酷太空船出现在Xcode中。 .scn文件称为场景，您所看到的是Xcode的内置SceneKit编辑器。

#### 创建Asset catalog

**PokerDice.scnassets**

![image-20190121215353081](https://ws1.sinaimg.cn/large/006tNc79gy1fzelfc80w2j314i0t0wr0.jpg)



#### 创建新的**SceneKit scene**

**SimpleScene.scn**

拖进**Sphere**，修改其半径为0.15

![image-20190121215736333](https://ws1.sinaimg.cn/large/006tNc79gy1fzelffvewaj31yo0s0e5a.jpg)



AR会话开始时，设备在现实世界中的位置定义了SceneKit空间中的（x：0，y：0，z：0）位置。 为了确保用户看到球体，您将它放置在场景中间一米处。 在仍然选择球体的情况下，选择节点检查器，然后将其位置更改为（x：0，y：0，z：-1）：

![image-20190121220025843](https://ws1.sinaimg.cn/large/006tNc79gy1fzelfkit17j30ee0fiq3v.jpg)



the two texture files



> 注意：由于资产目录是实际文件夹，因此您可以轻松地与团队中的其他艺术家和开发人员共享，从而轻松实现团队协作。 当您团队中的任何人更新此文件夹中的文件时，Xcode将自动使用最新信息更新您的所有场景。

![image-20190121220521656](https://ws2.sinaimg.cn/large/006tNc79gy1fzelfkx117j30ee0fiq3v.jpg)



#### 载入**SceneKit scenes**



```swift
let scene = SCNScene(named: "PokerDice.scnassets/SimpleScene.scn")!
```





#### 添加UI元素



![IMG_A458FF308462-1](https://ws3.sinaimg.cn/large/006tNc79gy1fzelfne6q7j30hb09qtdq.jpg)



#### 挑战



## 3-Basic Session Management



![](https://ws2.sinaimg.cn/large/006tNc79gy1fzsyqi19i9j30q00n4ju2.jpg)

### Starting an AR session



#### configuration

##### 3DOF

`AROrientationTrackingConfiguration`  

 **Pitch**, **Roll** and **Yaw**

rotation around the X-, Y- and Z-axes

![](https://ws3.sinaimg.cn/large/006tNc79gy1fzsyyxcd1dj30ra09wdg7.jpg)

##### 6DOF

`ARWorldTrackingConfiguration`  

**Sway**, **Heave** and **Surge**

movement parallel to the X-, Y- and Z- axes

![image-20190203091957485](/Users/andyron/Library/Application Support/typora-user-images/image-20190203091957485.png)

##### **Checking device capabilities**



```swift
let config = ARWorldTrackingConfiguration()
config.worldAlignment = .gravity
config.providesAudioData = false
```



#### Runing the session



### Controlling an AR session



**暂停：** `ARSession.pause()`

**重启：** `ARSession.run()`

**更新：** `ARSession.run(ARSessionConfig)`



### 更新状态信息



### **Handling AR session errors**



### Handing AR session state changes



```swift
func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
    switch camera.trackingState {
        case .notAvailable:
        trackingStatus = "Tracking: Not Available!"
        case .normal:
        trackingStatus = "Tracking: All Good"
        case .limited(let reason):
        switch reason {
            case .excessiveMotion:
            trackingStatus = "Tracking: Limited due to excessive motion!"
            case .insufficientFeatures:
            trackingStatus = "Tracking: Limited duo to insufficient features!"
            case .initializing:
            trackingStatus = "Tracking: Initializing..."
            case .relocalizing:
            trackingStatus = "Tracking: Relocalizing..."
        }
    }
}
```



**Tracking: Limited due to insufficient features!**: Put your finger over the camera, and this status will appear. Remove your finger, and it should return to **Tracking: All Good!** 

### debug options



