//
//  StoryViewController.m
//  ZhuHuDaily
//
//  Created by Wrappers Zhang on 2017/3/24.
//  Copyright © 2017年 Wrappers. All rights reserved.
//

#import "StoryViewController.h"

@interface StoryViewController ()

@end

@implementation StoryViewController


- (instancetype)initWithStoryId:(NSString *)storyId {
    self = [super init];
    self.storyId = storyId;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setBackButton];
    
    self.storyWebView.scalesPageToFit = YES;
    [_storyWebView loadHTMLString:@"<div class=\"main-wrap content-wrap\">\n<div class=\"headline\">\n\n<div class=\"img-place-holder\"></div>\n\n\n\n</div>\n\n<div class=\"content-inner\">\n\n\n\n\n<div class=\"question\">\n<h2 class=\"question-title\"></h2>\n\n<div class=\"answer\">\n\n<div class=\"content\">\n<p>回答来自<a href=\"https://www.zhihu.com/org-intro\">机构帐号</a>：<a class=\"author-link\" href=\"https://www.zhihu.com/org/knowyourself-1\" target=\"_blank\">KnowYourself</a></p>\n</div>\n</div>\n\n\n</div>\n\n\n\n\n\n<div class=\"question\">\n<h2 class=\"question-title\"></h2>\n\n<div class=\"answer\">\n\n<div class=\"meta\">\n<img class=\"avatar\" src=\"http://pic1.zhimg.com/v2-ff15524790f8c437b13dd9761430fe14_is.jpg\">\n<span class=\"author\">KnowYourself，</span><span class=\"bio\">宇宙中最酷的心理学社区：人人都能看懂，但只有一部分人才会喜欢</span>\n</div>\n\n<div class=\"content\">\n<p>看完答主们的从社交，从自我认同，从个人阅历等等方面来剖析这个问题，觉得很有意思。同时，我也想试着从一个不同的角度来解答这个问题：会不会那些抵触拍照的人只是更愿意全心地享受当下，而那些事无巨细都喜欢拍照记录的人，则只是单纯地想留下可以往后用来回味的凭据呢？</p>\r\n<p>著名心理学家、诺贝尔奖得主 Daniel Kahneman 曾提出过我们每个人在思考自己和他人时，都会使用到两个自我的这样一个观点。他将这两种自我分别命名为<strong>记忆自我（remembering self）</strong>与<strong>体验自我（experiencing self）</strong>。</p>\r\n<p>顾名思义，体验自我<strong>注重于每一个片刻的体验，活在当下，洞察当下。</strong>它虽然也有回味过去的功能，但基本上，它是只属于当下的。Daniel 在他的演讲中举出的一个经典的、关于体验自我的例子是，当医生问病人：&ldquo;我现在按你这个部位的时候疼吗？&rdquo; 这便是在问体验自我的感受。</p>\r\n<p>相对的，记忆自我负责的是<strong>记录生活，它着重于对一个事件，或是一段期间的生活的回忆和整体评价</strong>，而不是每时每刻的体验。同样是医生和病人的例子，会启用到记忆自我的问法会是：&ldquo;你最近一周感觉如何？&rdquo; 。</p>\r\n<p>值得注意的是，体验自我和记忆自我是两个截然不同的概念。并且，它们对于我们对&ldquo;幸福&rdquo;的定义和评价也有着完全不同的影响。举个例子，假如你听了一场优美绝伦的演奏会，在前 55 分钟它都给你带来了完美的视听体验。因此，对你的体验自我来说，每一个瞬间都是美妙的，令人享受的。但是，假如在演奏的最后 5 分钟，会场的音响出了故障，几分钟内整个大厅都被尖锐刺耳的杂音充斥着，那么大概很多人在事后回忆起来这场演奏会，会给出这样的评价：<strong>最后几分钟毁掉了整场美好的体验。</strong></p>\r\n<p>事实上，你之前愉悦的体验真的被毁掉了吗？答案是当然没有。前 55 分钟每一个瞬间，我们的体验自我都是实实在在享受到了的。而在事后回味时之所以会给出那样的评价，就要&ldquo;归功&rdquo;于我们的记忆自我了。因为，<strong>每一个当下都是转瞬即逝的，即便我们的体验自我尽情享受了每一个瞬间，最后我们也很难记得片刻的感受。</strong>Daniel 提到，从心理的角度上来说，我们每个&ldquo;片刻&rdquo;大约是 3 秒，而人生中有 6 亿多个这样的片刻。由此想来，它们的消失也就不令人咋舌了。而我们负责回忆，以及对一段回忆作出评价的记忆自我，则会严重地受到这段回忆中的一些极端事件和开头结尾的影响。</p>\r\n<p>接下来，回到问题本身：<em>是什么原因导致一些人抵触拍照，而另一些人无论吃饭旅行聚会都一定要时时举着摄像头呢？</em>我认为，或许只是<strong>前者更注重于体验，而后者更注重于记忆</strong>罢了，因为这两者实际上是无法完美兼顾的。</p>\r\n<p>以我自身经验为例，我曾经有段时间沉迷于给好看的食物拍照，在开动之前一定要等菜品全部上桌，最后摆盘五分钟，找角度五分钟，可能拍出一张满意的还要五分钟。最后，我在终于得到几张自己看得过去的照片的同时，也完美地错过了品尝眼前美食的最佳时机。甚至有时已经开始吃了，我的脑子里依然想着要给这些照片加什么样的滤镜。当然，这个例子或许有些夸张，但我想表达的其实就是：<strong>如果你想将眼前的美好以某种形式保留在回忆里，那么你当下的体验就必然会有所折扣。</strong>不过，即使我们每个人对这两种自我的重视度是不同的，能在它们之间找到一个平衡点的人，就会是最快乐的（Kahneman, 2011)。</p>\r\n<p>最后，Daniel 曾经问过他的学生这样一个问题，一个他认为可以完美体现这两种自我之间冲突的问题：如果你即将开始一段旅程，那是个美丽的地方，你知道自己会在那度过一段愉快的时光。但是，旅程回来，你在那里拍下的所有照片、影像都会被立即销毁，同时你还必须吞下一颗让你遗忘这段旅程的药。若是如此，你还会选择去吗？</p>\r\n<p>欢迎留言告诉我们你的答案。</p>\r\n<p>以上。</p>\r\n<p>了解更多与心理相关的知识、研究、话题互动、人物访谈等等，欢迎关注&nbsp;<a href=\"https://www.zhihu.com/org/knowyourself-1/activities\">KnowYourself - 知乎</a></p>\n</div>\n</div>\n\n\n<div class=\"view-more\"><a href=\"http://www.zhihu.com/question/38825317\">查看知乎讨论<span class=\"js-question-holder\"></span></a></div>\n\n</div>\n\n\n\n\n\n<div class=\"question\">\n<h2 class=\"question-title\"></h2>\n\n<div class=\"answer\">\n\n<div class=\"content\">\n<p><br class=\"Apple-interchange-newline\" />「知乎<span class=\"lG\">机构</span><span class=\"lG\">帐号</span>」是<span class=\"lG\">机构</span>用户专用的知乎<span class=\"lG\">帐号</span>，与知乎社区内原有的个人<span class=\"lG\">帐号</span>独立并行，其使用者为有正规资质的组织<span class=\"lG\">机构</span>，包括但不限于科研院所、公益组织、政府机关、媒体、企业等。这不仅是知乎对<span class=\"lG\">机构</span>的「身份认证」，更是涵盖了内容流通机制、<span class=\"lG\">帐号</span>规范等全套<span class=\"lG\">帐号</span>体系。和个人<span class=\"lG\">帐号</span>一样，<span class=\"lG\">机构</span><span class=\"lG\">帐号</span>开通不需要任何费用，同时也受社区规范的监督管理，并要遵守相关协议。目前<span class=\"lG\">机构</span><span class=\"lG\">帐号</span>入驻采用邀请制。您可以通过 &nbsp;<a href=\"http://zhihu.com/org-intro\" target=\"_blank\">什么是「知乎机构帐号」</a>&nbsp;来了解更多<span class=\"lG\">机构</span><span class=\"lG\">帐号</span>信息。</p>\n</div>\n</div>\n\n\n</div>\n\n\n</div>\n</div>" baseURL:[[NSURL alloc] initWithString:@"http://news-at.zhihu.com/css/news_qa.auto.css?v=4b3e3"]];
    [self.view addSubview:self.storyWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy 
- (UIWebView *)storyWebView {
    if (!_storyWebView) {
        _storyWebView = [[UIWebView alloc] initWithFrame:AppScreen];
    }
    return _storyWebView;
}
#pragma mark - UI
- (void)setBackButton {
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 50, 30)];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:17];
    [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    backButton.tintColor = [UIColor whiteColor];
    [self.view addSubview:backButton];
}
- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
