
tr98Parameter_t para_XGRE[] = {
	{ "TunnelNumberOfEntries", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ NULL, 0, 0, 0}
};

tr98Parameter_t para_XGRETunnel[] = {
	{ "Enable", PARAMETER_ATTR_WRITE, 0, json_type_boolean},
	{ "LowerLayers", PARAMETER_ATTR_WRITE, 1025, json_type_string},
	{ "RemoteEndpoint", PARAMETER_ATTR_WRITE, 257, json_type_string},
	{ "RemoteEndpoint2", PARAMETER_ATTR_WRITE, 257, json_type_string},
	{ "ConnRemoteEndpoint", PARAMETER_ATTR_WRITE, 257, json_type_string},
	{ "InterfaceGroup", PARAMETER_ATTR_READONLY, 257, json_type_string},
	{ "Checksum", PARAMETER_ATTR_WRITE, 0, json_type_boolean},
	{ "Seq", PARAMETER_ATTR_WRITE, 0, json_type_boolean},
	{ "Key", PARAMETER_ATTR_WRITE, 0, json_type_uint32},
	{ "ShapingRate", PARAMETER_ATTR_WRITE, 0, json_type_int},
	{ "DownstreamShapingRate", PARAMETER_ATTR_WRITE, 0, json_type_int},
	{ "DSCP", PARAMETER_ATTR_WRITE, 0, json_type_uint32},
	{ "VlanGroupNumberOfEntriesxsi", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ "MaxAssociatedDevices", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ NULL, 0, 0, 0}
};

tr98Parameter_t para_XGRETunnelStats[] = {
	{ "BytesSent", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ "BytesReceived", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ "PacketsSent", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ "PacketsReceived", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ "ErrorsSent", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ "ErrorsReceived", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ "DiscardPacketsSent", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ "DiscardPacketsReceived", PARAMETER_ATTR_READONLY, 0, json_type_uint32},
	{ NULL, 0, 0, 0}
};

