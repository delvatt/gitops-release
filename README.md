# gitops-release

This is fork of [@denispalnitsky](https://github.com/DenisPalnitsky)'s [gitops-release](https://github.com/DenisPalnitsky/gitops-release). The main change is an optional branch parameter that can be specified, in order to target a specific branch (creating it if not already existing) in the infra as code repositoy.

Github action to update yaml files inside another github repository.



## Example:
You have a release.yaml file in a `myorg/infra-as-code-repo` repository that has below content:

``` yaml
env:
  - dev:
    myServiceImageTag: "initial-ver"
```

Add this to github acion:

```
      - name: update gitops
        uses: delvatt/gitops-release@v7
        with:
          file: "release.yaml"
          key: "myServiceImageTag"
          value: '${{ github.ref }}
          github-token: ${{ secrets.GIT_ACCESS_TOKEN }}
          github-org-and-repo:  "myorg/infra-as-code-repo"
```
to update content of "myServiceImageTag" with git-ref value.

Alternatively, you can specify the base branch in the infra as code repository to be checked out:
```
      - name: update gitops
        uses: delvatt/gitops-release@v7
        with:
          file: "release.yaml"
          key: "myServiceImageTag"
          value: '${{ github.ref }}
          github-token: ${{ secrets.GIT_ACCESS_TOKEN }}
          github-org-and-repo:  "myorg/infra-as-code-repo"
          repo-base-branch:  "base-branch-name"
```

Also, to target a specifc branch where to apply the changes in the infra as a code repositoy, just add the target branch name as an extra parameter, just like this:
```
      - name: update gitops
        uses: delvatt/gitops-release@v7
        with:
          file: "release.yaml"
          key: "myServiceImageTag"
          value: '${{ github.ref }}
          github-token: ${{ secrets.GIT_ACCESS_TOKEN }}
          github-org-and-repo:  "myorg/infra-as-code-repo"
          repo-base-branch:  "base-branch-name"
          repo-target-branch:  "target-branch-name"
```
the branch will be checked out if it already exists or will be created if not.

Optionally, you can provide github username and email that will be used to commit the changes:
```
      - name: update gitops
        uses: delvatt/gitops-release@v7
        with:
          file: "release.yaml"
          key: "myServiceImageTag"
          value: '${{ github.ref }}
          github-token: ${{ secrets.GIT_ACCESS_TOKEN }}
          github-org-and-repo:  "myorg/infra-as-code-repo"
          repo-base-branch:  "base-branch-name"
          repo-target-branch:  "target-branch-name"
          github-username: gitops-user
          github-user-mail: bot@example.com
```
