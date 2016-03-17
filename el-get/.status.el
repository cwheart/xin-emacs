((el-get status "installed" recipe
	 (:name el-get :website "https://github.com/dimitri/el-get#readme" :description "Manage the external elisp bits and pieces you depend upon." :type github :branch "master" :pkgname "dimitri/el-get" :info "." :compile
		("el-get.*\\.el$" "methods/")
		:load "el-get.el"))
 (helm status "installed" recipe
       (:name helm :description "Emacs incremental and narrowing framework" :type github :pkgname "emacs-helm/helm" :compile nil))
 (python-mode status "installed" recipe
	      (:name python-mode :description "Major mode for editing Python programs" :type bzr :url "lp:python-mode" :load-path
		     ("." "test")
		     :compile nil :prepare
		     (progn
		       (autoload 'python-mode "python-mode" "Python editing mode." t)
		       (autoload 'doctest-mode "doctest-mode" "Doctest unittest editing mode." t)
		       (setq py-install-directory
			     (el-get-package-directory "python-mode"))
		       (add-to-list 'auto-mode-alist
				    '("\\.py$" . python-mode))
		       (add-to-list 'interpreter-mode-alist
				    '("python" . python-mode)))))
 (yaml-mode status "installed" recipe
	    (:name yaml-mode :description "Simple major mode to edit YAML file for emacs" :type github :pkgname "yoshiki/yaml-mode")))
