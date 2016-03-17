(add-to-list 'load-path "~/.emacs.d/")

(setq load-path (cons "~/.emacs.d/setting" load-path))
(require 'copy-and-move-line)
(require 'untabify-before-new-line)

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

;; 修改临时文件保存目录
(setq backup-directory-alist (quote (("." . "~/.emacs.backups"))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; 添加注释
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t))

;; 显示行号
(require 'linum+)
(global-linum-mode t)

;; 配色方案
(setq load-path (cons "~/.emacs.d/color-theme-6.6.0" load-path))
(require 'color-theme)
(color-theme-initialize)
(load-file "~/.emacs.d/color-theme-6.6.0/themes/color-theme-railscasts.el")
(color-theme-railscasts)
;; 中文斜体显示
(set-fontset-font
 (frame-parameter nil 'font)
 'han
 (font-spec :family "Hiragino Sans GB" ))

(require 'ido)
(require 'flx-ido)
(ido-mode t)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))

(require 'ruby-mode)

(add-hook
 'ruby-mode-hook
 '(lambda ()
    (remove-hook 'before-save-hook 'ruby-mode-set-encoding))) ;; 不自动设置ruby文件文件头部编码信息
(remove-hook 'write-file-hooks 'untabify-before-write) ;; 不自动删除行尾空格
