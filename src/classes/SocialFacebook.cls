global virtual with sharing class SocialFacebook extends cms.ContentTemplateController {
    public class SocialFacebookException extends Exception {}

    /** Returns the HTML for a "Like" Button */
    public String getLikeButtonHtml() {
        String html = '';

        html += getFacebookSdkPayload();

        html += '<div class="fb-like"';

        if(String.isNotBlank(likeUrl)) {
            html += ' data-href="' + likeUrl.escapeHtml4() + '"';
        }

        if(likeWidth != null) {
            html += ' data-width="' + likeWidth + '"';
        }

        html += ' data-layout="' + likeLayout.escapeHtml4() + '"'
                + ' data-action="' + likeAction.escapeHtml4() + '"'
                + ' data-show-faces="' + likeShowFaces + '"'
                + ' data-share="' + likeIncludeShare + '"'
            + '></div>';

        return html;
    }

    /** Return the HTML to embed a Facebook Page */
    public String getPageHtml() {
        String html = '';

        if(pageUrl == null) {
            throw new SocialFacebookException('No Facebook Page URL was specified.');
        }

        html += getFacebookSdkPayload();

        html += '<div class="fb-page"'
                + ' data-href="' + pageUrl.escapeHtml4() + '"'
                + ' data-tabs="' + pageTabs.escapeHtml4() + '"'
                + ' data-small-header="' + pageUseSmallHeader + '"'
                + ' data-adapt-container-width="' + pageUseAdaptiveWidth + '"'
                + ' data-hide-cover="' + pageHideCoverPhoto + '"'
                + ' data-show-facepile="' + pageShowFaces + '">';

        html += '<div class="fb-xfbml-parse-ignore">'
                    + '<blockquote cite="https://www.facebook.com/facebook">'
                        + '<a href="https://www.facebook.com/facebook">Facebook</a>'
                    + '</blockquote>'
                + '</div>'
            + '</div>';

        return html;
    }

    /** Returns the standard payload to include the Facebook Javascript SDK */
    private String getFacebookSdkPayload() {
        if(String.isBlank(appId)) {
            throw new SocialFacebookException('No Facebook App Id was specified.');
        }

        // Javascript to load Facebook's SDK
        return '<script>(function(d,s,id){'
            + 'var js,fjs=d.getElementsByTagName(s)[0];'
            + 'if(d.getElementById(id))return;'
            + 'js=d.createElement(s);js.id=id;'
            + 'js.src="//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.6&appId=' + appId.escapeHtml4() + '";'
            + 'fjs.parentNode.insertBefore(js,fjs);'
            + '}(document,\'script\',\'facebook-jssdk\'));</script>';
    }

    /** A Facebook App Id registered at developers.facebook.com */
    public String appId {
        get {
            return getAttribute('appId');
        }
    }

    /** The URL to like. If blank, the current page's URL will be used. */
    public String likeUrl {
        get {
            return getAttribute('likeUrl');
        }
    }

    /** The width of the like button in pixels. If blank/null it will not be passed to the widget. */
    public Integer likeWidth {
        get {
            String likeWidthString = getAttribute('likeWidth');
            Integer width;

            try {
                width = Integer.valueOf(likeWidthString);
            } catch(Exception e) {
                System.debug(e);
                return null;
            }

            if(width == null || width < 0) {
                return null;
            }

            return width;
        }
    }

    /** The layout to use. One of 'standard', 'box_count', 'button_count', 'button' */
    public String likeLayout {
        get {
            String layout = getAttribute('likeLayout');

            if(layout == 'standard' || layout == 'box_count' || layout == 'button_count' || layout == 'button') {
                return layout;
            } else {
                return 'standard';
            }
        }
    }

    /** The action to use on clicking the button. One of 'like' or 'recommend' */
    public String likeAction {
        get {
            String action = getAttribute('likeAction');

            if(action == 'like' || action == 'recommend') {
                return action;
            } else {
                return 'like';
            }
        }
    }

    /** Show faces of the current user's friends */
    public Boolean likeShowFaces {
        get {
            return getAttribute('likeShowFaces') == 'true';
        }
    }

    /** Include a 'Share' button as well as Like/Recommend */
    public Boolean likeIncludeShare {
        get {
            return getAttribute('likeIncludeShare') == 'true';
        }
    }

    /** The Facebook Page URL to embed */
    public String pageUrl {
        get {
            return getAttribute('pageUrl');
        }
    }

    /** The tabs to show on the embedded Facebook Page in CSV form */
    private String pageTabs {
        get {
            List<String> tabs = new List<String>();

            if(pageShowTimelineTab) {
                tabs.add('timeline');
            }

            if(pageShowEventsTab) {
                tabs.add('events');
            }

            if(pageShowMessagesTab) {
                tabs.add('messages');
            }

            return String.join(tabs, ',');
        }
    }

    /** Show the 'Timeline' tab */
    public Boolean pageShowTimelineTab {
        get {
            return getAttribute('pageShowTimelineTab') == 'true';
        }
    }

    /** Show the 'Events' tab */
    public Boolean pageShowEventsTab {
        get {
            return getAttribute('pageShowEventsTab') == 'true';
        }
    }

    /** Show the 'Messages' tab */
    public Boolean pageShowMessagesTab {
        get {
            return getAttribute('pageShowMessagesTab') == 'true';
        }
    }

    /** Use the small version of the Facebook Page's header */
    public Boolean pageUseSmallHeader {
        get {
            return getAttribute('pageUseSmallHeader') == 'true';
        }
    }

    /** Adaptively size the page */
    public Boolean pageUseAdaptiveWidth {
        get {
            return getAttribute('pageUseAdaptiveWidth') == 'true';
        }
    }

    /** Hide the cover photo of the embedded page */
    public Boolean pageHideCoverPhoto {
        get {
            return getAttribute('pageHideCoverPhoto') == 'true';
        }
    }

    /** Show faces on the embedded page */
    public Boolean pageShowFaces {
        get {
            return getAttribute('pageShowFaces') == 'true';
        }
    }

    /** Provides an easy way to define attributes during testing */
    @TestVisible
    private Map<String, String> testAttributes = new Map<String, String>();

    /** Delegates to ContentTemplateController#getAttribute in normal execution. Accesses the {@link #testAttributes}
     * map in a test context.
     */
    private String getAttribute(String attributeName) {
        if(Test.isRunningTest()) {
            return testAttributes.get(attributeName);
        } else {
            return getAttribute(attributeName);
        }
    }

    /** Extension constructor for the SocialFacebook edit page */
    global SocialFacebook(cms.CreateContentController cc) {
        super(cc);
    }

    /** Extension constructor for SocialFacebook generate pages (unused) */
    private SocialFacebook(cms.GenerateContent gc) {
        super(gc);
    }

    /** Constructor for getHTML rendering */
    global SocialFacebook() {
        super();
    }

    /** Blank getHTML - rendering is done by subclasses */
    global virtual override String getHTML() {
        return '';
    }
}
