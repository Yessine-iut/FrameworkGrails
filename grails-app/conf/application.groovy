

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'com.mbds.grails.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'com.mbds.grails.UserRole'
grails.plugin.springsecurity.authority.className = 'com.mbds.grails.Role'
grails.plugin.springsecurity.rest.token.storage.jwt.secret = "eyJhbGciOiJIUzI1NiJ9.eyJwcmluY2lwYWwiOiJINHNJQUFBQUFBQUFBSlZTdlVcL2JRQlJcL1RoTlJnVlNnRWtnZFlBRTI1RWgwek1SbjFjb05xR2tXa0VBWCsrRWVuT1wvTTNSbVNwY3BFaHd5cGFKRXFkZTNJZjlJdVwvUU5RTzNSbDd0cDNodURBZ25xVFwvZTduMzlmenhSVlVqSWJuc1daY0dEOFZXY3lsYjFMTlpXd3d6RFMzSFQ4enFDTzBPZUpGRG16U0JLNlBWd0l2Z0JLUExEd05EdGd4cXdvbTQrcG02d0JEVzJ0cldGSTZ2bUhjMXl6QkU2VVBcL1Z2dVVHbThJMUJRZTk5S01MSU5reXdNVlNadFhjbjFkc28xUnRzd1Vjd0NGUjY2MFZSSU55Z3RaOElNUTBkUXNwYkFLSUF4bHRsM2lsUTVHZ3ZqMTJZenkwVzFnYllXd09PVUdVUHU3aVZwV0dmZDNUdWJraEljd1hzb3QxT1BEblczNEtDKzRcL0ZYbFJDVW1pdHA1cHN5VVJIZjUwNmMrTHN6WnpcLzdYN3ZORWdCMXN2andOOFg4MlFwMHYrXC8rbmMyTDlrSUwwMFBXQzFpdG5aS2J5WUw1clVhbmZQbGw2OVA1MVllZFI2VHNFQnZcL3Y0XC81NVp2bU9xc3FTWmxtVmczdGlHaFB5dTZaeUZjZUpoOXNvZU0zZUpJS3BEOUtXb3h1SlFwaWlsdldTZ3o2dGpENlpqTlkzMXRlZVwvMnk3bDRyTEVxNEpOVW5lV2kzTFQ5UXRLdmVuNDhcLytuT1wvaU9FVlZJNlp5SkE2bnloQTlTeHBvVDY5T0o4WitcL3k3bHljWVwvTTNcL0FNaDBvOTRSQXdBQSIsInN1YiI6ImFkbWluIiwicm9sZXMiOlsiUk9MRV9BRE1JTiJdLCJpc3MiOiJTcHJpbmcgU2VjdXJpdHkgUkVTVCBHcmFpbHMgUGx1Z2luIiwiZXhwIjoxNjY0MzczMzEwLCJpYXQiOjE2NjQzNjk3MTB9.6DU80Ww_RZ75SpCWMK2f9SUNbo5eeUjLPyHASBqkdlY"
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',               access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/index.gsp',      access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/dbconsole/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	//Stateless chain
	[
			pattern: '/api/**',
			filters: 'JOINED_FILTERS,-anonymousAuthenticationFilter,-exceptionTranslationFilter,-authenticationProcessingFilter,-securityContextPersistenceFilter,-rememberMeAuthenticationFilter'
	],

	//Traditional, stateful chain
	[
			pattern: '/**',
			filters: 'JOINED_FILTERS,-restTokenValidationFilter,-restExceptionTranslationFilter'
	]]

