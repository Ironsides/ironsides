# Contributing to Ironsides

Ironsides is an open-access legal forms project. Courteous, well-reasoned feedback is welcome, appreciated, and recognized!

There are a number of ways to contribute to Ironsides, whether you're a technical whiz or a pen-and-paper kind of lawyer.

## Ground Rules

The Internet is a poor forum for dignified, dispassionate discussion. The Ironsides community is different. Conduct yourself at all times as if you are corresponding with the maintainer's elderly grandparent, and afford others the benefit of every doubt. The maintainer will moderate discussion along these lines.

Ironsides is a legal forms project, and many contributors are lawyers. However, Ironsides documents themselves may not be properly tailored to your needs, and contributors won't give legal advice via GitHub. The fact that a lawyer contributes to Ironsides doesn't mean they're available for hire or specialized in forming companies. Do not try phrasing your specific question as a "hypothetical". You will look foolish, and it won't work.

More generally, treat every message you see from the Ironsides community as if it came from an anonymous stranger. Does the message stand on its own?

Do _not_ share any confidential information via GitHub. GitHub is a very public place!

## Copyright

Whenever you propose a change to Ironsides, please include a note in your proposal that you make your contribution available to the public on the same [Creative Commons CC0 Universal 1.0 terms](./COPYING) as the rest of Ironsides. A simple note like "I, [Your Name], make this contribution available under CC0 Universal 1.0." will do.

## Discussion and Proposals

If you would like to make a comment or discuss Ironsides with the community, please see "Issues" below. If you would like to propose changes to Ironsides, please see "Changes" below. If you're not sure if you should make a proposal, and would like to talk about it with the community before starting work, have a look at "Issues" first.

### Issues

General discussion about Ironsides and ways to improve it happens via [GitHub Issues](https://github.com/Ironclad-ai/ironsides/issues). If you're not familiar with GitHub Issues, don't worry, they work pretty much like other Internet message boards. You will need to [create a (free) GitHub account](https://github.com/Ironclad-ai/ironsides/issues/new) to create new Issues for discussion and respond to Issues created by others.

Don't worry if you're not a programmer or techie-type. It's perfectly fine to use GitHub just for Issues.

### Changes

The Ironsides community uses GitHub Pull Requests to manage changes and discussion, but you don't have to use GitHub to contribute. If you can use GitHub and don't mind contributing using your GitHub account, please see "GitHub" below. If you're familiar with Google Drive, see "Google Drive" below. If you'd prefer to send more traditional markups by e-mail or postal mail, or if you'd prefer to contribute anonymously, see "Redlines" below.

Regardless of how you choose to submit changes, do not submit confidential information!

#### GitHub

Ironsides forms are written using [Common Form](https://commonform.github.io), a processing system for form contracts, as well as a lightweight preprocessor, also Written in JavaScript, that handles includes. All the form files are plain-text `.cform.template` files. The repository uses [Travis CI](https://travis-ci.org) to check forms for technical errors and build Microsoft Word and Portable Document Format documents for releases. The best way to learn to type form contracts in Common Form is to look at the `.cform` file for the form you want to change.

Please send pull requests from topic branches based on the current `master` branch. If you have any questions about Common Form or how Ironsides documents are built, feel free to open an Issue or mention your question in your Pull Request.

### Google Drive

The most recent official release of Ironsides is automatically published to Google Drive, where anyone can make suggestions and comments:

<https://drive.google.com/folderview?id=0B4WQgvqBs9InbmxhVGVCSm9xeFE&usp=sharing>

The maintainer will receive an e-mail for any suggestion or comment you make via Google Drive.

#### Redlines

If you would prefer to send a more traditional redline with proposed changes and comments, you can send them to Ironsides' maintainer at <kyle@kemitchell.com> or Kyle E. Mitchell, 156 Second Street, San Francisco, California 94105. The maintainer will not accept e-mail or hard copy contributions of comments alone.

The maintainer will make every effort to process and share well-considered proposals with the community. The maintainer may ignore submissions that seem spurious, nettlesome, or duplicative of proposals already accepted or declined by the community.

##### Format

If you send a proposal via e-mail, please provide in one of the following formats:

1. A Microsoft Word file with Track Changes
2. A Microsoft Word file generated by a legal redline generation tool
3. A Portable Document Format file with annotations
4. A patch generated with `git format-patch`

If you send edits in hard copy, _please, for the love of God, print legibly_! The maintainer is a busy practicing attorney, and will recycle illegible submissions.

Please also make use of standard edit marks, such as those described by The Texas Law Review's _Manual on Usage & Style_, _The Chicago Manual of Style_, or a nationally known financial printer's manual. Helpfully indicate in your e-mail or cover page what edit marks you have used.

Whether you send by e-mail or postal mail, make sure to identify the version number of the Ironsides documents that you began to edit.

In addition to your markup and comments, please include your name, e-mail address, and the statement described under "Copyright" above. The maintainer will use your e-mail address to confirm receipt and notify you if a Pull Request (an Issue that includes proposed changes) is created on GitHub for your proposal. The maintainer will not share your e-mail address with anyone.

The maintainer will endeavor to process e-mail and postal submissions as quickly as possible in order received. Please be patient.

##### Anonymous and Claimable Proposals

Unless you specify otherwise, the maintainer will post every e-mail and postal mail proposal to GitHub as a Pull Request with mention of your name. The maintainer may take steps to verify that the proposal comes from the author named.

The maintainer will process your proposal differently if you write "This proposal is [type of proposal listed below]." in your e-mail or cover letter.

1. *Anonymous*. The maintainer will post your proposal to GitHub as a Pull Request with mention that it was made anonymously.

2. *Claimable*.  If you provide a secret passphrase of at least 5 English words, the maintainer will retain the passphrase in secret and post your proposal as if it were made anonymously. On later receipt of the passphrase and a request to claim the proposal, the maintainer will identify claimant as the author of the proposal.

If you submit an anonymous or claimable proposal, be sure to include your name nonetheless. The maintainer may discard submissions that introduce substantial new changes without an attributable statement described by "Copyright" above.

## Maintainer

Kyle E. Mitchell (@kemitchell on GitHub) maintains Ironsides.
