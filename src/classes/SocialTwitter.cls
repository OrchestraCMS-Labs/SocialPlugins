global virtual with sharing class SocialTwitter extends cms.ContentTemplateController {
    /** Render a Twitter widget. These are all stored as plain HTML. */
    global virtual override String getHTML() {
        return twitterHtml;
    }

    /** The stored HTML for a Twitter widget */
    public String twitterHtml {
        get {
            return getAttribute('twitterHtml');
        }
    }

    /** Editor only: When true, the twitterHtml attribute will be saved as a language-independent
     * attribute. When false, the author must provide a translated piece of widget markup for every
     * language
     */
    public Boolean useSingleLanguageConfiguration {
        get {
            return getAttribute('useSingleLanguageConfiguration') == 'true';
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

    /** Extension constructor for the SocialTwitter edit page */
    global SocialTwitter(cms.CreateContentController cc) {
        super(cc);
    }

    /** Extension constructor for SocialTwitter generate pages (unused) */
    private SocialTwitter(cms.GenerateContent gc) {
        super(gc);
    }

    /** Constructor for getHTML rendering */
    global SocialTwitter() {
        super();
    }
}
