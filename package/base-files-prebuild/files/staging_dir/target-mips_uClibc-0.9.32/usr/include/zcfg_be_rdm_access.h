#ifndef _ZCFG_BE_RDM_ACCESS_H
#define _ZCFG_BE_RDM_ACCESS_H

zcfgRet_t zcfgBeObjGetNext(zcfg_offset_t, objIndex_t *, void **);
zcfgRet_t zcfgBeObjGetNextWithoutUpdate(zcfg_offset_t, objIndex_t *, void **);
zcfgRet_t zcfgBeObjGet(zcfg_offset_t, objIndex_t *, void **);
zcfgRet_t zcfgBeObjQueryExist(zcfg_offset_t , objIndex_t *);
zcfgRet_t zcfgBeObjGetWithoutUpdate(zcfg_offset_t, objIndex_t *, void **);
zcfgRet_t zcfgBeObjSetWithoutApply(zcfg_offset_t, objIndex_t *, void *, char *);
zcfgRet_t zcfgBeObjSet(zcfg_offset_t, objIndex_t *, void *, char *);
zcfgRet_t zcfgBeObjAdd(zcfg_offset_t, objIndex_t *);
zcfgRet_t zcfgBeObjAddWithoutApply(zcfg_offset_t, objIndex_t *);
zcfgRet_t zcfgBeObjDel(zcfg_offset_t, objIndex_t *, char *);
zcfgRet_t zcfgBeGetNextInSub(zcfg_offset_t , objIndex_t *, objIndex_t *, void **);
zcfgRet_t zcfgBeGetNextInSubWithoutUpdate(zcfg_offset_t, objIndex_t *, objIndex_t *, void **);
zcfgRet_t zcfgBeReqMsgSend(int, int, zcfg_offset_t, objIndex_t *, int, char *);
zcfgRet_t zcfgBeSaveParamValue(zcfg_offset_t, objIndex_t *, char *, void *);
zcfgRet_t zcfgBeObjIdToName(zcfg_offset_t , objIndex_t *, char *);
zcfgRet_t zcfgBeNameToObjId(const char *, objIndex_t *);
zcfgRet_t zcfgBeLowerLayerStatusGet(char *, char *);
#ifdef ZCFG_TR98_TR181_OBJECT_MAPPING_REBUILD
void zcfgBeReqMappingTableRebuild();
#else
#define zcfgBeReqMappingTableRebuild() {}
#endif

struct json_object *zcfgBeApplyObjRetrievePartialObj(void *obj);

void zcfgBeCreateConfigSymLink(char *);
void zcfgBeRemoveConfigSymLink(char *);

#define zcfgBeObjFree(obj) free(obj); obj = NULL
#endif
