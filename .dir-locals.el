((nil . ((eval . (when (not (assoc "^cl-app$" slime-filename-translations))
                   (push (docker-slime-translation "cl-app")
                         slime-filename-translations))))))
