import { humanReadableDate } from '@/core/utils/dateTime';
import { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import {
  addDevices,
  removeDevices,
  addDevice,
} from '@/lib/store/services/addMonitor/selectedCollocateDevicesSlice';

const DataTable = ({ filteredData, collocationDevices }) => {
  const dispatch = useDispatch();
  const selectedCollocateDevices = useSelector(
    (state) => state.selectedCollocateDevices.selectedCollocateDevices,
  );

  const handleSelectAllDevices = (e) => {
    const allDevices = [];
    collocationDevices.map((device) => allDevices.push(device._id));
    if (e.target.checked) {
      dispatch(addDevices(allDevices));
    } else {
      dispatch(removeDevices(allDevices));
    }
  };

  const handleSelectDevice = (e, device) => {
    const isChecked = e.target.checked;
    if (isChecked) {
      dispatch(addDevices([device._id]));
    } else {
      dispatch(removeDevices([device._id]));
    }
  };

  return (
    <table className='border-collapse text-sm text-left w-full mb-6'>
      <thead>
        <tr className='border-b border-b-slate-300 text-black'>
          <th scope='col' className='font-normal w-[61px] py-[10px] px-[21px]'>
            <input
              type='checkbox'
              checked={selectedCollocateDevices.length === collocationDevices.length}
              onChange={handleSelectAllDevices}
            />
          </th>
          <th scope='col' className='font-normal w-[175px] px-4 py-3 opacity-40'>
            Monitor name
          </th>
          <th scope='col' className='font-normal w-[175px] px-4 py-3 opacity-40'>
            Added by
          </th>
          <th scope='col' className='font-normal w-[175px] px-4 py-3 opacity-40'>
            Start date
          </th>
          <th scope='col' className='font-normal w-[175px] px-4 py-3 opacity-40'>
            End date
          </th>
          <th scope='col' className='font-normal w-[175px] px-4 py-3 opacity-40'>
            Status
          </th>
        </tr>
      </thead>
      <tbody>
        {filteredData.length > 0 &&
          filteredData.map((device) => {
            return (
              <tr className='border-b border-b-slate-300' key={device._id}>
                <td scope='row' className='w-[61px] py-[10px] px-[21px]'>
                  <input
                    type='checkbox'
                    checked={selectedCollocateDevices.includes(device._id)}
                    value={device}
                    onChange={(e) => handleSelectDevice(e, device)}
                  />
                </td>
                <td scope='row' className='w-[175px] px-4 py-3'>
                  {device.device_id}
                </td>
                <td scope='row' className='w-[175px] px-4 py-3'>
                  {' '}
                </td>
                <td scope='row' className='w-[175px] px-4 py-3'>
                  {humanReadableDate(device.start_date)}
                </td>
                <td scope='row' className='w-[175px] px-4 py-3'>
                  {humanReadableDate(device.end_date)}
                </td>
                <td scope='row' className='w-[175px] px-4 py-3'>
                  {device.status}
                </td>
              </tr>
            );
          })}
      </tbody>
    </table>
  );
};

export default DataTable;
