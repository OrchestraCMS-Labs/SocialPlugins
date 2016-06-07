global virtual with sharing class SocialFacebookPage extends SocialFacebook {
    public override String getHtml() {
        return getPageHtml();
    }
}
