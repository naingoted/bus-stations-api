<?php namespace App\Repositories\Interfaces;

interface BusRepositoryInterface
{
    public function findBusesByStationId($stationId);
}