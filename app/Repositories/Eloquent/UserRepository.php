<?php

namespace App\Repositories\Eloquent;


use App\Repositories\BaseEloquentAPIRepository;
use App\Repositories\Interfaces\UserRepositoryInterface;
use App\Models\User;

class UserRepository extends BaseEloquentAPIRepository implements UserRepositoryInterface
{
    /**
    * UserRepository constructor.
    *
    * @param User $model
    */
   public function __construct(User $model)
   {
       parent::__construct($model);
   }

   public function orderBy($column, $direction) {
        return $this->model->orderBy($column, $direction);
   }
}