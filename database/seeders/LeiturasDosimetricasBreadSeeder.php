<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use TCG\Voyager\Models\DataRow;
use TCG\Voyager\Models\DataType;
use TCG\Voyager\Models\Menu;
use TCG\Voyager\Models\MenuItem;
use TCG\Voyager\Models\Permission;
use TCG\Voyager\Models\Role;

class LeiturasDosimetricasBreadSeeder extends Seeder
{
    public function run(): void
    {
        $dataType = DataType::firstOrNew(['slug' => 'leituras-dosimetricas']);
        if (! $dataType->exists) {
            $dataType->fill([
                'name'                  => 'leituras_dosimetricas',
                'display_name_singular' => 'Leitura Dosimétrica',
                'display_name_plural'   => 'Leituras Dosimétricas',
                'icon'                  => 'voyager-activity',
                'model_name'            => 'App\\LeituraDosimetrica',
                'controller'            => '',
                'generate_permissions'  => 1,
                'description'           => 'Leituras mensais de dosímetro individual — Medicina do Trabalho (MEDt)',
                'server_side'           => 0,
            ])->save();
        }

        $rows = [
            ['id',              'number',           'Id',               1, 0, 0, 0, 0, 0,  1, (object)[]],
            ['professional_id', 'select_dropdown',  'Profissional',     1, 0, 0, 1, 1, 1,  2, [
                'relationship' => [
                    'key'   => 'id',
                    'label' => 'person_name',
                ],
                'model'        => 'App\\Professional',
                'description'  => 'Trabalhador exposto à radiação ionizante.',
            ]],
            ['professional_belongsto_professional_relationship', 'relationship', 'Profissional', 0, 1, 1, 0, 0, 0, 2, [
                'model'       => 'App\\Professional',
                'table'       => 'professionals',
                'type'        => 'belongsTo',
                'column'      => 'professional_id',
                'key'         => 'id',
                'label'       => 'person_name',
                'pivot_table' => 'leituras_dosimetricas',
                'pivot'       => '0',
                'taggable'    => '0',
            ]],
            ['mes_referencia',  'date',             'Mês de Referência', 1, 1, 1, 1, 1, 1, 3, [
                'description' => 'Use o primeiro dia do mês (ex: 2026-05-01).',
            ]],
            ['valor_msv',       'number',           'Valor (mSv)',       1, 1, 1, 1, 1, 1, 4, [
                'step' => '0.001',
                'min'  => '0',
                'description' => 'Valor lido no dosímetro no mês.',
            ]],
            ['tipo',            'text',             'Tipo de Dosímetro', 0, 1, 1, 1, 1, 1, 5, [
                'description' => 'Ex: tórax, extremidade, cristalino.',
            ]],
            ['observacoes',     'text_area',        'Observações',       0, 0, 1, 1, 1, 1, 6, (object)[]],
            ['faixa',           'text',             'Faixa',             0, 1, 1, 0, 0, 0, 7, [
                'description' => 'Calculado automaticamente.',
            ]],
            ['conduta',         'text_area',        'Conduta Médica',    0, 0, 1, 0, 0, 0, 8, [
                'description' => 'Calculado automaticamente.',
            ]],
            ['prazo',           'text',             'Prazo',             0, 1, 1, 0, 0, 0, 9, [
                'description' => 'Calculado automaticamente.',
            ]],
            ['created_at',      'timestamp',        'Criado em',         0, 1, 1, 0, 0, 0, 10, (object)[]],
            ['updated_at',      'timestamp',        'Atualizado em',     0, 0, 0, 0, 0, 0, 11, (object)[]],
        ];

        foreach ($rows as [$field, $type, $display, $required, $browse, $read, $edit, $add, $delete, $order, $details]) {
            $row = DataRow::firstOrNew([
                'data_type_id' => $dataType->id,
                'field'        => $field,
            ]);
            $row->fill([
                'type'         => $type,
                'display_name' => $display,
                'required'     => $required,
                'browse'       => $browse,
                'read'         => $read,
                'edit'         => $edit,
                'add'          => $add,
                'delete'       => $delete,
                'order'        => $order,
                'details'      => $details,
            ])->save();
        }

        Permission::generateFor('leituras_dosimetricas');

        $adminRole = Role::where('name', 'admin')->first();
        if ($adminRole) {
            $perms = Permission::where('table_name', 'leituras_dosimetricas')->pluck('id');
            $adminRole->permissions()->syncWithoutDetaching($perms);
        }

        $menu = Menu::where('name', 'admin')->firstOrFail();

        $parent = MenuItem::firstOrNew([
            'menu_id' => $menu->id,
            'title'   => 'Medicina do Trabalho (MEDt)',
        ]);
        if (! $parent->exists) {
            $parent->fill([
                'url'        => '',
                'route'      => null,
                'target'     => '_self',
                'icon_class' => 'voyager-medical',
                'color'      => null,
                'parent_id'  => null,
                'order'      => 35,
            ])->save();
        }

        $child = MenuItem::firstOrNew([
            'menu_id' => $menu->id,
            'title'   => 'Leituras Dosimétricas',
            'route'   => 'voyager.leituras-dosimetricas.index',
        ]);
        if (! $child->exists) {
            $child->fill([
                'url'        => '',
                'target'     => '_self',
                'icon_class' => 'voyager-activity',
                'color'      => null,
                'parent_id'  => $parent->id,
                'order'      => 2,
            ])->save();
        }

        $dash = MenuItem::firstOrNew([
            'menu_id' => $menu->id,
            'title'   => 'Dashboard MEDt',
            'route'   => 'medt.dashboard',
        ]);
        if (! $dash->exists) {
            $dash->fill([
                'url'        => '',
                'target'     => '_self',
                'icon_class' => 'voyager-dashboard',
                'color'      => null,
                'parent_id'  => $parent->id,
                'order'      => 1,
            ])->save();
        }

        $imp = MenuItem::firstOrNew([
            'menu_id' => $menu->id,
            'title'   => 'Importar CSV',
            'route'   => 'medt.import.form',
        ]);
        if (! $imp->exists) {
            $imp->fill([
                'url'        => '',
                'target'     => '_self',
                'icon_class' => 'voyager-upload',
                'color'      => null,
                'parent_id'  => $parent->id,
                'order'      => 3,
            ])->save();
        }
    }
}
