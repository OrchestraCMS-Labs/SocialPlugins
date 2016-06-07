@isTest
private with sharing class SocialFacebook_Test {
    private static testmethod void testGetLikeButtonHtml_withUrlAndWidth() {
        SocialFacebook controller = new SocialFacebook();

        controller.testAttributes = new Map<String, String> {
            'appId' => 'app id',
            'likeUrl' => 'http://www.stantive.com',
            'likeWidth' => '150'
        };

        String likeButtonHtml = controller.getLikeButtonHtml();

        System.assert(String.isNotBlank(likeButtonHtml), 'Should return an HTML string');
        System.assert(likeButtonHtml.contains('data-href'), 'Should contain the data-href attribute');
        System.assert(likeButtonHtml.contains('data-width'), 'Should contain the data-width attribute');
    }

    private static testmethod void testGetLikeButtonHtml_withoutUrlAndWidth() {
        SocialFacebook controller = new SocialFacebook();

        controller.testAttributes = new Map<String, String> {
            'appId' => 'app id'
        };

        String likeButtonHtml = controller.getLikeButtonHtml();

        System.assert(String.isNotBlank(likeButtonHtml), 'Should return an HTML string');
        System.assert(!likeButtonHtml.contains('data-href'), 'Should not contain the data-href attribute');
        System.assert(!likeButtonHtml.contains('data-width'), 'Should not contain the data-width attribute');
    }

    private static testmethod void testGetLikeButtonHtml_defaults() {
        SocialFacebook controller = new SocialFacebook();

        try {
            controller.getLikeButtonHtml();
            System.assert(false, 'Should throw an exception if no app id is specified');
        } catch(SocialFacebook.SocialFacebookException ex) {
            // Expected
        }
    }

    private static testmethod void testGetPageHtml_valid() {
        SocialFacebook controller = new SocialFacebook();

        controller.testAttributes = new Map<String, String> {
            'appId' => 'app id',
            'pageUrl' => 'https://www.facebook.com/stantive'
        };

        String pageHtml = controller.getPageHtml();

        System.assert(String.isNotBlank(pageHtml), 'Should return an HTML string');
    }

    private static testmethod void testGetPageHtml_noPageUrl() {
        SocialFacebook controller = new SocialFacebook();

        controller.testAttributes = new Map<String, String> {
            'appId' => 'app id'
        };

        try {
            controller.getPageHtml();
            System.assert(false, 'Should throw an exception if pageUrl is not specified');
        } catch(SocialFacebook.SocialFacebookException ex) {
            // Expected
        }
    }

    private static testmethod void testGetPageHtml_defaults() {
        SocialFacebook controller = new SocialFacebook();

        try {
            controller.getPageHtml();
            System.assert(false, 'Should throw an exception if appId and pageUrl are not specified');
        } catch(SocialFacebook.SocialFacebookException ex) {
            // Expected
        }
    }

    private static testmethod void testLikeLayout() {
        SocialFacebook controller = new SocialFacebook();

        String[] allowedLayouts = new String[] { 'standard', 'box_count', 'button_count', 'button' };
        String invalidLayout = 'invalid layout';
        String defaultLayout = 'standard';

        // likeLayout attribute = null
        System.assertEquals(defaultLayout, controller.likeLayout, 'Should return the default layout when null');


        controller = new SocialFacebook();
        controller.testAttributes = new Map<String, String> {
            'likeLayout' => invalidLayout
        };
        System.assertEquals(defaultLayout, controller.likeLayout,
            'Should return the default layout when an invalid layout is saved');


        for(String allowedLayout : allowedLayouts) {
            controller = new SocialFacebook();
            controller.testAttributes = new Map<String, String> {
                'likeLayout' => allowedLayout
            };
            System.assertEquals(allowedLayout, controller.likeLayout,
                'Should return the specified layout ' + allowedLayout);
        }
    }

    private static testmethod void testLikeAction() {
        SocialFacebook controller = new SocialFacebook();

        String[] allowedActions = new String[] { 'like', 'recommend' };
        String invalidAction = 'invalid action';
        String defaultAction = 'like';

        // likeAction attribute = null
        System.assertEquals(defaultAction, controller.likeAction, 'Should return the default action when null');


        controller = new SocialFacebook();
        controller.testAttributes = new Map<String, String> {
            'likeAction' => invalidAction
        };
        System.assertEquals(defaultAction, controller.likeAction,
            'Should return the default action when an invalid action is saved');


        for(String allowedAction : allowedActions) {
            controller = new SocialFacebook();
            controller.testAttributes = new Map<String, String> {
                'likeAction' => allowedAction
            };
            System.assertEquals(allowedAction, controller.likeAction,
                'Should return the specified action ' + allowedAction);
        }
    }
}
