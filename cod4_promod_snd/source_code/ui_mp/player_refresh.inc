#define INDEX_ACCURACY 2325
#define STATTODVAR_ACCURACY execNow "statGetInDvar 2325 ui_stat_accuracy"
#define INDEX_TIME_PLAYED_OTHER 2313
#define STATTODVAR_TIME_PLAYED_OTHER execNow "statGetInDvar 2313 ui_stat_time_played_other"
#define INDEX_TIME_PLAYED_OPFOR 2312
#define STATTODVAR_TIME_PLAYED_OPFOR execNow "statGetInDvar 2312 ui_stat_time_played_opfor"
#define INDEX_TIME_PLAYED_ALLIES 2311
#define STATTODVAR_TIME_PLAYED_ALLIES execNow "statGetInDvar 2311 ui_stat_time_played_allies"
#define INDEX_SUICIDES 2310
#define STATTODVAR_SUICIDES execNow "statGetInDvar 2310 ui_stat_suicides"
#define INDEX_TEAMKILLS 2309
#define STATTODVAR_TEAMKILLS execNow "statGetInDvar 2309 ui_stat_teamkills"
#define INDEX_HEADSHOTS 2308
#define STATTODVAR_HEADSHOTS execNow "statGetInDvar 2308 ui_stat_headshots"
#define INDEX_ASSISTS 2307
#define STATTODVAR_ASSISTS execNow "statGetInDvar 2307 ui_stat_assists"
#define INDEX_DEATH_STREAK 2306
#define STATTODVAR_DEATH_STREAK execNow "statGetInDvar 2306 ui_stat_death_streak"
#define INDEX_DEATHS 2305
#define STATTODVAR_DEATHS execNow "statGetInDvar 2305 ui_stat_deaths"
#define INDEX_KILL_STREAK 2304
#define STATTODVAR_KILL_STREAK execNow "statGetInDvar 2304 ui_stat_kill_streak"
#define INDEX_KILLS 2303
#define STATTODVAR_KILLS execNow "statGetInDvar 2303 ui_stat_kills"
#define INDEX_SCORE 2302
#define STATTODVAR_SCORE execNow "statGetInDvar 2302 ui_stat_score"
#define INDEX_RANKXP 2301
#define STATTODVAR_RANKXP execNow "statGetInDvar 2301 ui_stat_rankxp"

#define STAT_UPDATE \
	STATTODVAR_TIME_PLAYED_OTHER; \
	STATTODVAR_TIME_PLAYED_OPFOR; \
	STATTODVAR_TIME_PLAYED_ALLIES; \
	STATTODVAR_TEAMKILLS; \
	STATTODVAR_HEADSHOTS; \
	STATTODVAR_ASSISTS; \
	STATTODVAR_DEATH_STREAK; \
	STATTODVAR_DEATHS; \
	STATTODVAR_KILL_STREAK; \
	STATTODVAR_KILLS; \
	STATTODVAR_SCORE; \
	STATTODVAR_RANKXP; \
	STATTODVAR_ACCURACY; \
	STATTODVAR_SUICIDES;
}
