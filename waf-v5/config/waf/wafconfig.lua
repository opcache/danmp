local M = {
    RulePath = "/etc/nginx/conf.d/waf/wafconf/", -- 匹配规则路径
    attacklog = "on", -- 是否开启日志
    logdir = "/data/nginx-log/waflogs/", -- 日志目录
    UrlDeny = "on", -- 是否检测url
    Redirect = "on", -- 是否提示拦截
    CookieMatch = "on", -- 是否检测cookie
    postMatch = "off", -- 是否检测post参数
    whiteModule = "on", -- 是否检测url白名单
    black_fileExt = {"php", "jsp","html"}, -- 上传文件后缀检测
    ipWhitelist = {"127.0.0.1"}, -- 白名单ip列表，支持*做正则
    ipBlocklist = {"1.0.0.1"}, -- 黑名单ip列表，支持*做正则
    CCDeny = "on", -- 是否做cc防攻击检测
    CCrate = "100/10", -- ip访问特定url频率（次/秒）
    ipCCrate = "120/10", -- ip访问服务器频率（次/秒）
}

return M
