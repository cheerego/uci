### 常用指令

```
php artisan make:model Pipeline

php artisan make:migration --create=pipelines create_pipelines_table 

php artisan admin:make PipelineController --model=App\\Models\\Pipeline
 
php artisan admin:action Pipeline\\Trigger --grid-row --name="触发构建"

```
