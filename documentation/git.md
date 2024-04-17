# Git

## Git book

https://git-scm.com/book/de

## Git Cheatsheet

http://ndpsoftware.com/git-cheatsheet.html

## What should i do?
Click on the image to see it in full size

<img src="http://justinhileman.info/article/git-pretty/git-pretty.png" width="700px">

## Git flow

http://nvie.com/posts/a-successful-git-branching-model

If youn want to use git-flow, you should install it first:
```shell
brew install git-flow-avh
```

## Git Tree

https://coderwall.com/p/4-itow/nice-terminal-git-tree-graph


## Good commits: Rewrite the history of your feature branch

In an ideal world while developing you make reasonable git commits in the first place (develop & commit step by step). However in many cases some unexpected changes are necessary, you receive input from code reviews or you simply want to use another implementation approach.
To keep the history of a git repository (its main branches like main/master/staging/develop) clean, it's mandatory to provide good commits in a MR.

Some guidelines:  
- split up unrelated changes into several commits (even if it's only small changes)
- avoid squashing everything you did together into one commit (this is also possible through the Gitlab UI, however not wanted in many cases)
- think before commit and push to have a cleaner history from the beginning
- if you're unhappy with the history of your branch you can do one of this:
    - use git reset to undo all commits, then step by step commit everything again (`git reset HEAD~2` means undoing the last 2 commits, but keep the changes locally for example)
    - use a tool like [Github Desktop](https://desktop.github.com/) and use Drag&Drop to squash commits (useful if you added a typo-fix and want to include it in another commit for example) or change their order
    - use `git rebase -i` (basically the same like the line above only on the console: https://thoughtbot.com/blog/git-interactive-rebase-squash-amend-rewriting-history)

## Add changes to previous commits (not the last one)
**Attention**: Changing the history of a branch can be dangerous, take a look at [this](/useful-links/git.md) if you are not sure what you're doing.  
Sometimes you want to add a change to some older commit on your branch.  
Take a look at this history and imagine you have some changed file in your working branch which (logically) belongs to the marked commit, so you probably don't want to ammend it to the last commit.

![git_history](/_src/git_tips_1.png)


This is what you can do in that case:

1. Stash your changes
2. Enter the interactive rebase (`git rebase -i HEAD~10`), adjust the number of commits if you have to; you can also use the commit SHA of the commit before if you want (`git rebase -i 4fa0485`)
3. Change `pick` to e(dit) for the commit you want to change and save
4. Pop your changes from the stash (`git stash pop`)
5. Git add them, ammend them to the commit (`git add your_changes` & `git commit --ammend`)
6. Save the commit and continue the interactive rebase: `git rebase --continue`
7. 🎉 Almost done, now do a force push to change history! 🧙

