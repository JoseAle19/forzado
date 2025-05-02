import 'package:flutter/material.dart';
import 'package:forzado/core/configs/theme/app_colors.dart';
import 'package:forzado/pages/aprobador/provider/forzados_provider.dart';
import 'package:forzado/pages/aprobador/screen/detail_approve_forzado.dart';
import 'package:forzado/pages/ejecutor/models/aprobador.dart';
import 'package:provider/provider.dart';

class ListForzadosAppro extends StatefulWidget {
  const ListForzadosAppro({super.key, this.isAlta});
  final isAlta;

  @override
  State<ListForzadosAppro> createState() => _ListForzadosApproState();
}

class _ListForzadosApproState extends State<ListForzadosAppro> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     if (mounted) {
        await getData();
      }
    });
  }


Future<void> getData() async {
    final providerForzados =
        Provider.of<ForzadosProviderApprove>(context, listen: false);
    await providerForzados.initLoadSolicitudes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(widget.isAlta ? "Consultas":"Consultas"),
      ),
      body: Consumer<ForzadosProviderApprove>(builder: (context, value, child) {
        return value.loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              )
            : value.messageError.isNotEmpty && value.loading ==false ?
            Center(child: Text(value.messageError),)
            :
            value.listForzados.where((f)=> f.estado!.toUpperCase()=='PENDIENTE-FORZADO' && f.estado!.toUpperCase() !='PENDIENTE-RETIRO').isEmpty ? const Center(child: Text('No Tiene retiros pendientes por Aprobar'),) :
            ListView.separated(
              itemCount: value.listForzados.length,
              separatorBuilder: (BuildContext context, int index) {
                ForzadoApprove  forzado = value.listForzados[index];
                return forzado.estado?.toUpperCase() != 'PENDIENTE-FORZADO'&& forzado.estado?.toUpperCase() != 'PENDIENTE-RETIRO' ? const SizedBox.shrink() :const Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                ForzadoApprove  forzado = value.listForzados[index];
              
              
                return forzado.estado?.toUpperCase() != 'PENDIENTE-FORZADO'&& forzado.estado?.toUpperCase() != 'PENDIENTE-RETIRO' ? const SizedBox.shrink() :  Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue.shade100,
                            child: Text(
                              '${forzado.id}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID: ${forzado.id}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Descripción
                                Text(
                                  forzado.estado!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailApproveForzado(
                                      detailForzado: forzado,
                                      isAlta: widget.isAlta),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue,
                              size: 20,
                            ),
                            splashRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  );
              },
            );
      }),
    );
  }
}