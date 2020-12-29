(package! company-org-roam
  :recipe (:host github :repo "org-roam/company-org-roam"))
(package! elpy)
(package! org-fragtog)
(package! org-ref)
(package! org-roam-bibtex
  :recipe (:host github :repo "org-roam/org-roam-bibtex"))
(package! org-roam-server
  :recipe (:host github :repo "org-roam/org-roam-server"))
(package! poetry)

(unpin! org-roam)
(unpin! bibtex-completion helm-bibtex ivy-bibtex)
