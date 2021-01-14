(package! company-org-roam
  :recipe (:host github :repo "org-roam/company-org-roam"))
(package! dockerfile-mode)
(package! elpy)
(package! emmet-mode)
(package! gif-screencast
  :recipe (:host gitlab :repo "ambrevar/emacs-gif-screencast"))
(package! indent-tools)
(package! org-download)
(package! org-fragtog)
(package! org-ref)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(package! org-roam-server
  :recipe (:host github :repo "org-roam/org-roam-server"))
(package! yaml-mode)

(unpin! org-roam)
(unpin! bibtex-completion helm-bibtex ivy-bibtex)
