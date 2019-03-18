#define TAILLE 1024

//void yyerror(char *);

typedef enum Type Type;
enum Type {INT = 8, CONST_INT = 8};

struct ligne_ts {
  unsigned int ts_addr;
  char* ts_name;
  Type ts_type;
  unsigned int ts_profondeur;
};

struct ligne_ts ts[TAILLE];

unsigned int ts_index;

unsigned int ts_profondeur_actuelle;

void ts_init (void);

void ts_declaration(char* name, Type type, unsigned int profondeur);

unsigned int ts_get_addr(int indice);
