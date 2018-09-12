void esmdLanConnectionUp(objIndex_t *);
void esmdLanMacFilterSet(objIndex_t *);
bool isBindingBridgeWan(char *ethIntfPath);
#ifdef ISKON_CUSTOMIZATION_Motorola_VIP1003
extern int removeIfaceGroup(char *portName, bool confirmed);
#else
int removeIfaceGroup(char *portName);
#endif
