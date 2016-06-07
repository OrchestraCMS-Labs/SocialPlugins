@isTest
private with sharing class SocialTwitter_Test {
	private static testmethod void testGetHtml() {
		SocialTwitter controller = new SocialTwitter();
		String testHtml = 'sample twitter embed';

		controller.testAttributes = new Map<String, String> {
			'twitterHtml' => testHtml
		};

		System.assertEquals(testHtml, controller.getHTML(), 'Should exactly return the twitterHtml attribute');
	}

	private static testmethod void testUseSingleLanguageConfiguration() {
		SocialTwitter controller = new SocialTwitter();

		// Default to false
		System.assert(!controller.useSingleLanguageConfiguration, 'Should default to false');

		controller = new SocialTwitter();
		controller.testAttributes = new Map<String, String> {
			'useSingleLanguageConfiguration' => 'true'
		};
		System.assert(controller.useSingleLanguageConfiguration, 'Should be true if \'true\' is stored');
	}
}
