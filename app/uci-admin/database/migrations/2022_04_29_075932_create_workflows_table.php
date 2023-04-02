<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateWorkflowsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('workflows', function (Blueprint $table) {
            $table->id();
            $table->string("name");
            $table->text("yaml");
            $table->integer("creator_id");
//            $table->text("trigger_method");
//            $table->text("scheduler");
            $table->text("envs");

            $table->integer("latest_pipeline_id")->default(0)->comment("最后一次流水线 ID");
            $table->integer("latest_success_pipeline_id")->default(0)->comment("最后一次成功构建流水线 ID");
            $table->integer("max_concurrent")->default(5);
            $table->integer("build_timeout_second")->default(30 * 60)->comment("构建超时时间");
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('workflows');
    }
}
