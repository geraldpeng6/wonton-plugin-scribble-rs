# shellcheck shell=bash
# scripts/smoke.sh 的一项一项探测，跟着插件走。没写的项会 FAIL 并给出写法，不会默认放行。
#
# 变量：SMOKE_WEB_URL 是应用的网页入口（套件已去尾斜杠，但可能带路径，比如 SSO 登录页）；
#       拼 API 路径用 SMOKE_WEB_ORIGIN（只有 scheme://host:port，入口的路径不掺进来），别直接接在 SMOKE_WEB_URL 后面。
#
# 页面：web_assert 从标准输入读页面，命中的确是应用的真实页面时返回 0。
# 身份：应用没有任何账号体系，进网页就能玩；网关那一层（Wonton 会话）由套件自己验证。写 IDENTITY_NA=1。
# 工具：本插件没有 MCP 工具，MCP_TOOL 不写。
# 数据：大厅和玩家都只在内存里，应用不落盘；升级、重装后大厅自然为空，没有可保的数据。写 DATA_NA=1。

web_assert() { # 建大厅页：标题和自定义词输入框都在，才认作应用真实页面
  grep -q '<title>Scribble.rs</title>' && grep -q 'name="custom_words"'
}

export IDENTITY_NA=1
export SMOKE_NOTE="应用没有账号体系，打开网页即玩；网关的 Wonton 会话由套件自己验证"
export DATA_NA=1
