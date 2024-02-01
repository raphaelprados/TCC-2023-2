
#include <iostream>
#include <time.h>
#include <stdlib.h>
#include "mpi.h"

#define TAMMAX 100

void geraVetor(int c, int vet[TAMMAX]);
void geraMatriz(int l, int c, int mat[TAMMAX][TAMMAX]);
void transposta(int l, int c, int mat[TAMMAX][TAMMAX], int mat_t[TAMMAX][TAMMAX]);

int main(int argc, char  *argv[]) {
    
    int i, j, size, rank;
    int mat[TAMMAX][TAMMAX], vet[TAMMAX];
    int result[TAMMAX];

    MPI_Init(NULL, NULL);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    int tam = TAMMAX / size;
    int matAux[tam][TAMMAX], matTransp[TAMMAX][TAMMAX];
    int vetAux[tam], resAux[TAMMAX];

    if(rank == 0) {
        geraMatriz(TAMMAX, TAMMAX, mat);
        geraVetor(TAMMAX, vet);
        transposta(TAMMAX, TAMMAX, mat, matTransp);
    }

    // Espalha a matriz
    MPI_Scatter(&matTransp, tam * TAMMAX, MPI_INT, &matAux, tam * TAMMAX, MPI_INT, 
                0, MPI_COMM_WORLD);
    // Espalha o vetor
    MPI_Scatter(&vet, tam, MPI_INT, &vetAux, tam, MPI_INT, 0, MPI_COMM_WORLD);

    memset(&resAux, 0, sizeof(int)*TAMMAX);
    for(i = 0; i < tam; i++)
        for(j = 0; j < TAMMAX; j++)
            resAux[j] += matAux[i][j] * vetAux[i];

    MPI_Reduce(&resAux, &result, TAMMAX, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
    if(rank == 0) {
        std::cout << std::endl;
        for(int i = 0 ; i < TAMMAX; i++) 
            std::cout << " " << result[i] << " ";
        std::cout << std::endl;
    }

    MPI_Finalize();   

    return 0;
}

void geraVetor(int c, int vet[TAMMAX]) {
    srand(time(NULL));
    for(int i = 0; i < c; i++) {
        vet[i] = rand() % 10;
        std::cout << " " << vet[i] << " ";
    }
    std::cout << std::endl;
}

void geraMatriz(int l, int c, int mat[TAMMAX][TAMMAX]) {
    srand(time(NULL));
    for(int i = 0; i < l; i++) {
        for(int j = 0; j < c; j++) {
            mat[i][j] = rand() % 10;
            std::cout << " " << mat[i][j] << " ";
        }
        std::cout << std::endl;
    }
    std::cout << std::endl;
}

void transposta(int l, int c, int mat[TAMMAX][TAMMAX], int mat_t[TAMMAX][TAMMAX]) {
    for(int i = 0; i < l; i++)
        for(int j = 0; j < c; j++)
            mat_t[i][j] = mat[j][i];
}
