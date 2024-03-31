local opt = vim.opt

-- tab/indent
opt.tabstop = 4  -- 이미 입력된 값
opt.softtabstop = 4 -- 내가 입력할때
opt.shiftwidth = 4  -- 자동 들여쓰기 4칸
opt.wrap = false  -- 자동 줄바꿈 안함
opt.expandtab = true  -- tab을 space로 변환
opt.smartindent = true -- 똑똑한 들여쓰기 사용
opt.autoindent = true -- 자동 들여쓰기 사용
opt.cindent = true -- c 형태의 들여쓰기 사용

-- search
opt.incsearch = true  -- 찾는 중에 바로바로 검색됨
opt.ignorecase = true  -- 검색시 대소문자를 구별하지 않음
opt.smartcase = true  -- 똑똑한 대소문자 구별 기능 사용(모두소문자면 구분x, 한개라도 대문자면 구분)
opt.hlsearch = true  -- 검색어 강조 기능
opt.wrapscan = true  -- 계속 찾기
opt.history = 100 -- 명령어 기록을 남길 갯수 지정

-- GUI 
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
--opt.signcolumn = "yes"
opt.splitbelow = true -- split screen default below location 
opt.splitright = true -- split screen default right location
opt.colorcolumn = "120"
opt.sc = true  -- 완성중인 명령을 표시

-- support
opt.foldmethod = "marker"   -- fold setting
opt.foldmarker = "{{{,}}}"  -- fold setting
opt.showmatch = true -- 괄호 매칭
opt.showcmd = true -- 부분적인 명령어를 상태라인에 보여줌
opt.wmnu = true -- Tab 자동 완성시 가능한 목록을 보여줌
opt.backspace = "indent,eol,start"  -- 줄의 들여쓰기, 끝, 시작에서 백스페이스 사용시 이전줄과 연결 
opt.autoread = true

-- etc
opt.encoding = "UTF-8"
--opt.cmdheight = 1
opt.mouse:append("a")
opt.backup = false -- backup 파일 자동생성 안함
opt.writebackup = false -- 
opt.swapfile = false -- swap 파일 자동생성 안함
opt.tags= "./tags,tags,../tags,../../tags,../../../tags,../../../../tags"
