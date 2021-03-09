<?php 
namespace App\Repositories;

use App\Repositories\BaseRepositoryInterface;
use App\Traits\ResponseAPI;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\ModelNotFoundException;


class BaseEloquentAPIRepository implements BaseRepositoryInterface
{
    // Use ResponseAPI Trait in repository
    use ResponseAPI;
    // model property on class instances
    protected $model;

    // Constructor to bind model to repo
    public function __construct(Model $model)
    {
        $this->model = $model;
    }

    // Get all instances of model
    public function all()
    {
        try {
            return $this->success("Retrieved successfully", $this->model->all());
        } catch(\Exception $e) {
            return $this->error($e->getMessage(), $e->getCode());
        }
    }

    // create a new record in the database
    public function create(array $data)
    {
        try {
            return $this->success("Added successfully", $this->model->create($data), 201);
        } catch(\Exception $e) {
            return $this->error($e->getMessage(), $e->getCode());
        }
    }

    // update record in the database
    public function update(array $data, $id)
    {
        DB::beginTransaction();
        try {
            $record = $this->find($id);
            // Check the record
            if(!$record) return $this->error("No data with ID $id", 404);
            // Update the record
            if($record->update($data)){
                DB::commit();
                return $this->success("Updated successfully", $record);
            }else{
                DB::rollBack();
                return $this->error("Update failed. Try again.", 404);
            }
        } catch(\Exception $e) {
            DB::rollBack();
            return $this->error($e->getMessage(), $e->getCode());
        }
    }

    // remove record from the database
    public function delete($id)
    {
        DB::beginTransaction();
        try {
            $record = $this->find($id);
            // Check the record
            if(!$record) return $this->error("No data with ID $id", 404);
            // Delete the record
            $this->model->destroy($id);
            DB::commit();
            return $this->success("Record deleted", $record);
        } catch(\Exception $e) {
            DB::rollBack();
            return $this->error($e->getMessage(), $e->getCode());
        }
    }

    // show the record with the given id
    public function show($id)
    {
        try {
            return $this->success("Success", $this->model-findOrFail($id));
        } catch(ModelNotFoundException $e) {
            return $this->error($e->getMessage(), $e->getCode());
        }
    }

    // Get the associated model
    public function getModel()
    {
        return $this->model;
    }

    // Set the associated model
    public function setModel($model)
    {
        $this->model = $model;
        return $this;
    }

    // Eager load database relationships
    public function with($relations)
    {
        return $this->model->with($relations);
    }

    /**
	 * Paginate all
	 * @param  integer $perPage
	 * @param  array   $columns
	 * @return \Illuminate\Pagination\Paginator          
	 */
    public function paginate($perPage = 15, $columns = ['*'])
	{
        try {
            $recordList = $this->model->paginate($perPage, $columns);
            return $this->success("Success", $recordList);
        } catch(\Exception $e) {
            return $this->error($e->getMessage(), $e->getCode());
        }
    }

    public function search(array $params)
    {
        $query = $this->model->newQuery();
        foreach ($params as $field => $input) {
            $query->where($field, 'like', '%'.$input.'%');
        }
        return $query;
    }
    
}