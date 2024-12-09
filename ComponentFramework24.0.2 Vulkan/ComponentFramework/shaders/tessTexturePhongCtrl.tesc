#version 450 
layout(vertices = 3) out;

layout(set = 0, binding = 0) uniform TessellationLevels {
    float tessLevelInner;
    float tessLevelOuter;
};


layout(location = 0) in vec2 uvCoordFromVert[];
layout(location = 1) in vec3 normalFromVert[];
layout(location = 2) in float vertDistance[];

layout(location = 0) out vec2 uvCoordFromCtrl[];
layout(location = 1) out vec3 normalFromCtrl[];
layout(location = 2) out float vertDistanceOut[];

void main() {
    // Pass through input vertices to tessellation evaluation stage
    gl_out[gl_InvocationID].gl_Position =  gl_in[gl_InvocationID].gl_Position;
    uvCoordFromCtrl[gl_InvocationID] = uvCoordFromVert[gl_InvocationID];
    normalFromCtrl[gl_InvocationID] = normalFromVert[gl_InvocationID];
    vertDistanceOut[gl_InvocationID] = vertDistance[gl_InvocationID];

   float tesslevel = 10.0;
    // Set tessellation levels
    if (gl_InvocationID == 0) {
        
        if(vertDistance[0] < 30.0){
            tesslevel = 20.0;
        }else if (vertDistance[0] < 50){
            tesslevel = 5.0;
        }else{
            tesslevel = 1.0;
        }
        gl_TessLevelInner[0] = tesslevel;//tessLevelInner;

        gl_TessLevelOuter[0] = tesslevel;
        gl_TessLevelOuter[1] = tesslevel;
        gl_TessLevelOuter[2] = tesslevel;

    }
}
