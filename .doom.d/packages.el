(package! autothemer)
(package! company-org-roam
  :recipe (:host github :repo "org-roam/company-org-roam"))
(package! dockerfile-mode)
(package! emacs-conflict
  :recipe (:host github :repo "ibizaman/emacs-conflict"))
(package! emmet-mode)
(package! exec-path-from-shell)
(package! gif-screencast
  :recipe (:host gitlab :repo "ambrevar/emacs-gif-screencast"))
(package! indent-tools)
(package! org-download)
(package! org-fragtog)
(package! org-ref)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(package! org-roam-ui
  :recipe (:host github :repo "org-roam/org-roam-ui" :files ("*.el" "out")))
(package! treemacs-persp)
(package! websocket)
(package! yaml-mode)


(unpin! org-roam)
(unpin! bibtex-completion helm-bibtex ivy-bibtex)
