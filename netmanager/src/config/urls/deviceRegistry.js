import { stripTrailingSlash } from '../utils';

const BASE_DEVICE_REGISTRY_URL = stripTrailingSlash(process.env.REACT_APP_BASE_URL);

const BASE_DEVICE_REGISTRY_URL_V2 = stripTrailingSlash(process.env.REACT_APP_BASE_URL_V2);

export const ACTIVITY_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/activities`;

export const REGISTER_DEVICE_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices`;

export const ALL_DEVICES_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices`;

export const EDIT_DEVICE_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices`;

export const SOFT_EDIT_DEVICE_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/soft`;

export const DEVICES_IN_LOCATION_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/by/location?loc=`;

export const DEPLOY_DEVICE_URI = `${BASE_DEVICE_REGISTRY_URL}/devices/activities/deploy`; // Change to V2

export const ADD_MAINTENANCE_LOGS_URI = `${BASE_DEVICE_REGISTRY_URL}/devices/activities/maintain`; // Change to V2

export const DELETE_DEVICE_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/ts/delete`;

export const ADD_COMPONENT_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/add/components?device=`;

export const GET_COMPONENTS_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/list/components`;

export const DELETE_COMPONENT_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/delete/components?comp=`;

export const UPDATE_COMPONENT_URI = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/update/components?device=`;

export const UPDATE_COMPONENT = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/update/components`;

export const DELETE_COMPONENT = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/delete/components`;

export const DELETE_DEVICE_PHOTO = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/photos`;

export const RECALL_DEVICE_URI = `${BASE_DEVICE_REGISTRY_URL}/devices/activities/recall`; // Change to V2

export const EVENTS = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/events?tenant=airqo`;

export const SITES = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/sites`;

export const AIRQLOUDS = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/airqlouds?tenant=airqo`;

export const REFRESH_AIRQLOUD = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/airqlouds/refresh`;

export const DASHBOARD_AIRQLOUDS = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/airqlouds/dashboard`;

export const DECRYPT = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/decrypt`;

export const QRCODE = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/qrcode`;

export const SOFT_EDIT_DEVICE_IMAGE = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/photos/soft?tenant=airqo`;

export const GET_DEVICE_IMAGES = `${BASE_DEVICE_REGISTRY_URL_V2}/devices/photos?tenant=airqo`;
