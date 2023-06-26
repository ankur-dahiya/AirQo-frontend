import axios from 'axios';
import { GET_HEATMAP_DATA, GET_GEOCOORDINATES_DATA } from 'config/urls/predict';

let token = localStorage.jwtToken;
if (token) {
  axios.defaults.headers.common.Authorization = token;
} else {
  axios.defaults.headers.common.Authorization = `JWT ${process.env.REACT_APP_AUTHORIZATION_TOKEN}`;
}

const API_TOKEN = process.env.REACT_APP_API_TOKEN

export const heatmapPredictApi = async () => {
  return await axios.get(GET_HEATMAP_DATA, {
    params:{
      token: API_TOKEN,
      limit: 10000
    }
  }).then((response) => response.data);
};

export const geocoordinatesPredictApi = async (params) => {
  return await axios.get(GET_GEOCOORDINATES_DATA, { params }).then((response) => response.data);
};
