#!/bin/bash

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 函数：打印带颜色的消息
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查是否在git仓库中
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_error "当前目录不是一个git仓库"
    exit 1
fi

# 检查是否有未提交的更改
if git diff-index --quiet HEAD --; then
    print_info "没有检测到本地更改，无需推送"
    exit 0
fi

print_info "检测到本地更改，开始分析变更内容..."

# 获取变更的文件列表
changed_files=$(git diff --name-only HEAD)
staged_files=$(git diff --cached --name-only)
added_files=$(git ls-files --others --exclude-standard)

# 生成提交信息
generate_commit_message() {
    local msg=""
    local file_count=0
    
    # 统计变更类型
    local modified_count=$(git diff --name-only HEAD | wc -l | tr -d ' ')
    local staged_count=$(git diff --cached --name-only | wc -l | tr -d ' ')
    local added_count=$(git ls-files --others --exclude-standard | wc -l | tr -d ' ')
    
    # 分析主要变更类型
    if echo "$changed_files $staged_files $added_files" | grep -q "README.md\|SUMMARY.md"; then
        msg="docs: 更新文档结构和内容"
    elif echo "$changed_files $staged_files $added_files" | grep -q "chapter[0-9]\+/"; then
        msg="content: 更新章节内容"
    elif echo "$changed_files $staged_files $added_files" | grep -q "\.md$"; then
        msg="docs: 更新Markdown文档"
    elif echo "$changed_files $staged_files $added_files" | grep -q "book.json\|deploy.sh"; then
        msg="config: 更新配置文件"
    elif echo "$changed_files $staged_files $added_files" | grep -q "assets/\|images/"; then
        msg="assets: 更新资源文件"
    else
        msg="update: 更新项目文件"
    fi
    
    # 添加文件数量信息
    local total_changes=$((modified_count + staged_count + added_count))
    if [ $total_changes -gt 1 ]; then
        msg="$msg ($total_changes 个文件)"
    fi
    
    echo "$msg"
}

# 如果用户提供了自定义提交信息，使用用户提供的信息
if [ $# -eq 1 ]; then
    commit_msg="$1"
    print_info "使用用户提供的提交信息: $commit_msg"
else
    commit_msg=$(generate_commit_message)
    print_info "自动生成提交信息: $commit_msg"
fi

# 显示将要提交的更改
print_info "将要提交的更改:"
if [ -n "$changed_files" ]; then
    echo -e "${YELLOW}修改的文件:${NC}"
    echo "$changed_files" | sed 's/^/  - /'
fi

if [ -n "$added_files" ]; then
    echo -e "${GREEN}新增的文件:${NC}"
    echo "$added_files" | sed 's/^/  - /'
fi

# 添加所有更改到暂存区
print_info "添加更改到暂存区..."
git add -A

# 检查是否有内容可以提交
if git diff-index --quiet HEAD --; then
    print_warning "没有内容需要提交"
    exit 0
fi

# 提交更改
print_info "提交更改..."
if git commit -m "$commit_msg"; then
    print_success "提交成功: $commit_msg"
else
    print_error "提交失败"
    exit 1
fi

# 推送到远程仓库
print_info "推送到远程仓库..."
if git push origin master; then
    print_success "推送成功！"
    print_info "部署完成，更改已同步到远程仓库"
else
    print_error "推送失败，请检查网络连接和权限"
    exit 1
fi


