global virtual with sharing class SocialFacebookLike extends SocialFacebook {
    public override String getHtml() {
        return getLikeButtonHtml();
    }
}
