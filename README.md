# Social Plugins

<!-- MarkdownTOC depth=3 -->

1. [Summary](#summary)
    1. [Compatibility](#compatibility)
    1. [Prerequisites](#prerequisites)
    1. [Deployment](#deployment)
    1. [Configuration](#configuration)
1. [Versioning](#versioning)
    1. [Major Versions](#major-versions)
    1. [Minor Versions](#minor-versions)
    1. [Patch Versions](#patch-versions)

<!-- /MarkdownTOC -->

<a name="summary"></a>
## Summary

The set of Social Plugins content types provide functionality to embed Facebook and Twitter widgets.

The Facebook content type allows authors to embed a customizable
[Facebook Like widget](https://developers.facebook.com/docs/plugins/like-button) with the *FacebookLike* content
templates, and a customizable [Facebook Page Widget](https://developers.facebook.com/docs/plugins/page-plugin) with the
*FacebookPage* content template.

The Twitter content type allows authors to embed either Twitter's [Buttons](https://about.twitter.com/resources/buttons)
or [Account-Specific Widgets](https://twitter.com/settings/widgets).

<a name="compatibility"></a>
### Compatibility

This content type requires a minimum of OrchestraCMS package 7.184 (Winter 2016, v7.3 Build #7.184).

<a name="prerequisites"></a>
### Prerequisites

1. A compatible version of OrchestraCMS is installed in the target Salesforce organization.
2. A site has been created in OrchestraCMS.

<a name="deployment"></a>
### Deployment

1. Deploy the following Apex classes to the target Salesforce organization
    1. SocialFacebook.cls
    2. SocialFacebook_Test.cls
    3. SocialFacebookLike.cls
    4. SocialFacebookPage.cls
    5. SocialTwitter.cls
    6. SocialTwitter_Test.cls
2. Deploy the following Visualforce pages to the target Salesforce organization
    1. SocialFacebookLike_Edit.page
    2. SocialFacebookPage_Edit.page
    3. SocailTwitter_Edit.page

<a name="configuration"></a>
### Configuration

Create OrchestraCMS Content Layout records with the following field values:

```
Name : FacebookLike
Label : Facebook Like
Controller : SocialFacebookLike
isPageCacheable : true
isContentCacheable : true
Visualforce Edit : c__SocialFacebookLike_Edit
```

```
Name : FacebookPage
Label : Facebook Page
Controller : SocialFacebookPage
isPageCacheable : true
isContentCacheable : true
Visualforce Edit : c__SocialFacebookPage_Edit
```

```
Name : Twitter
Label : Twitter
Controller : SocialTwitter
isPageCacheable : true
isContentCacheable : true
Visualforce Edit : c__SocialTwitter_Edit
```

On the target OrchestraCMS site create the following content type(s) and add content templates as indicated.

```
Name: Facebook
Label: Facebook
Templates:
    Facebook Like, default
    Facebook Page
```

```
Name: Twitter
Label: Twitter
Templates:
    Twitter, default
```

<a name="versioning"></a>
## Versioning

Versions of this content type are numbered MAJOR.MINOR.PATCH.

Any modifications to this code outside of this repository are customizations and will impact upgradeability.

<a name="major-versions"></a>
### Major Versions

Major versions introduce new functionality and may break existing implementations.

<a name="minor-versions"></a>
### Minor Versions

Minor versions introduce new functionality, but will not break existing implementations.

<a name="patch-versions"></a>
### Patch Versions

Patches correct defects in the implementation and do not introduce new functionality.
