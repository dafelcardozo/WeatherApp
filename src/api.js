import axios from 'axios';

export const measurements = (field, year, month) => axios.get(`${process.env.VUE_APP_WS_URL}/field_measurements?field=${field}&month=${month}&year=${year}`);
