module = "yb-book"
ctanupload = true
typesetopts = "-interaction=batchmode -shell-escape -halt-on-error"
checkopts = "-interaction=batchmode -shell-escape -halt-on-error"
tagfiles = {"build.lua", "yb-book.dtx"}
docfiles = {"yb-book-logo.pdf"}
cleanfiles = {"*.glo", "*.fls", "*.idx", "*.out", "*.fdb_latexmk", "*.aux", "*.cls"}

uploadconfig = {
  pkg = "yb-book",
  version = "0.4.0",
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
    "0000%-00%-00", os.date("%d.%m.%Y")
  )
end
