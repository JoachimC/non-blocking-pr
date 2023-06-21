Ideas around a Non-Blocking PR workflow

# Why
The aim of Non-blocking Pull Requests is to reduce time wasted waiting and/or context switching between writing code and reviewing it.

The goal is definitely **not** to reduce the amount of review. Rather do all the necessary checks - automated and manual - in way that is more efficient.

## Other potential benefits
* Facilitate changes in smaller, more frequent increments
* Provide space for the 'right' person to take the time to do a more thorough review - rather than just relying on the 'next' person available

## Cautions
* GitHub tooling is based around blocking code reviews so might not naturally facilitate this workflow. [See pr-check script](#pr-check-script)
* Busy code bases with multiple concurrent contributors might have problems if they also have regular low quality contributions - necessitating reverts/hot-fix branches, and/or obstructing subsequent changes being released.
* Might require rigourous adoption of other Continuous Integration / Delivery practices[^3] to reduce the chances of low quality commits disrupting flow on `main`
* Not likely to be suitable for public projects where (potential) contributors are unknown.

# Steps
## Develop
1) Create branch from `main`, make changes.
2) Commit/push/rebase branch. 
3) Raise PR.[^1]
4) Ensure automated build checks/tests pass.
5) Merge PR to `main`.
6) Request review.
7) goto 1).

## Review
1) Receive request to review from 6) above.
2) Review as normal - making comments / suggestions.
3) Developer follows [Develop](#develop) process above to make any subsequent changes on new branches from `main`.

## Release/Deploy
1) Check all PRs merged before this have been reviewed and approved. [See pr-check script](#pr-check-script)
2) Create release.

# Notes
* Operating this flow does not preclude using Blocking Pull Requests as and when required - for changes that are identified as requiring a more cautious (but less efficient) introduction into `main`.

# pr-check script
* [pr-check script](pr-check.ps1).
* Requires powershell, and [`gh` cli](https://cli.github.com/manual/installation).
* Tested on windows only.

# References
* https://tidyfirst.substack.com/p/thinking-about-code-review
* https://thinkinglabs.io/articles/2023/05/02/continuous-code-reviews-using-non-blocking-reviews-a-case-study.html
* https://www.youtube.com/watch?v=WmVe1QrWxYU
* https://www.scrum-tips.com/agile/synchronous-code-reviews/
* https://andywine.dev/non-blocking-code-reviews-github/

[^1]: I suggest raising a draft PR with the first commit pushed to the branch and push to the shared/remote branch regularly after that. This ensures that other collaborators can see what I'm working on and if required pick up where I left off (improve the [bus factor](https://en.wikipedia.org/wiki/Bus_factor) ). This also provides a back-up if anything goes awry on my local machine/branch.

[^3]: e.g. High quality test coverage, diligent collective co-ownership, and [Andon](https://en.wikipedia.org/wiki/Andon_(manufacturing)) for `main` breakages.
