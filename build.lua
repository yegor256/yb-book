-- (The MIT License)
--
-- Copyright (c) 2021-2025 Yegor Bugayenko
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the 'Software'), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

module = "yb-book"
ctanupload = true
typesetopts = "-interaction=batchmode -shell-escape -halt-on-error"
checkopts = "-interaction=batchmode -shell-escape -halt-on-error"
tagfiles = {"build.lua", "yb-book.dtx"}
docfiles = {"yb-book-logo.pdf"}
cleanfiles = {"*.glo", "*.fls", "*.idx", "*.out", "*.fdb_latexmk", "*.aux", "*.cls"}

uploadconfig = {
  pkg = "yb-book",
  version = "0.6.0",
  author = "Yegor Bugayenko",
  uploader = "Yegor Bugayenko",
  email = "yegor256@gmail.com",
  note = "Bug fixes",
  announcement = "",
  ctanPath = "/macros/latex/contrib/yb-book",
  bugtracker = "https://github.com/yegor256/yb-book/issues",
  home = "",
  description = "This template helps the author design books published on Amazon under the “Y.B.” brand. You are welcome to use it too for your own books.",
  development = "",
  license = "mit",
  summary = "Template for YB Branded Books",
  repository = "https://github.com/yegor256/yb-book",
  support = "",
  topic = {"class", "doc-templ", "book-pub"}
}

function update_tag(file, content, tagname, tagdate)
  return string.gsub(
    string.gsub(content, "0%.0%.0", tagname),
    "2025/01/08", os.date("%Y/%m/%d")
  )
end
